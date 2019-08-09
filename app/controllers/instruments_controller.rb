class InstrumentsController < ApplicationController
  respond_to :js, :html

  NUM_DUPLICATES = 30
  FIELDS = 'id,instrument_id,datasource_id,ticker,standard_name,effective_date,expiration_date,figi,sedol,isin,cusip,exchange_country,currency,exchange,approved,default_instrument'
    
  before_action :authenticate_user!

  def duplicate
    @source_map = Hash.new
    Datasource.all.each do |d|
      @source_map[d.id] = d.data_source_name
    end
    
    @dup_sets = []
    @set_map = {}
    
    # Instead of these three - simplify!
    create_dup_set('cusip', @dup_sets, @set_map, 20)
    create_dup_set('isin', @dup_sets, @set_map, 40)
    #create_isin_cusip_set(@dup_sets, @set_map)
    #create_field_set('exchange_country', @dup_sets, @set_map, 20)
    #create_ambiguous_set(@dup_sets, @set_map, 30)
    
    # Currency ones don't seem to be valid, per Joey - try just ignoring them
    #if @dup_sets.count <= NUM_DUPLICATES
    #  create_field_set('currency', @dup_sets, @set_map)
    #end
    
    render :layout => 'admin'
  end
  
  def resolve_ambiguous
    to_delete = []
    remap = Hash.new
    
    params.each do |key, value|
      if key =~ /instrument_(\d+)/
        set_num = $1
        id_set = params["instrument_idset_#{set_num}"].split
        # Keep value and delete the rest
        if id_set.include?(value)
          id_set.each do |id|
            unless value == id
              to_delete.push(id)
              remap[id] = value
            end
          end
        else
          raise "Unknown instrument_id: #{value}"
        end
      end
    end
    
    to_delete.each do |id|
      if remap.has_key?(id)
        StagingConstituent.where(:instrument_id => id).update_all(:instrument_id => remap[id])
      end
      
      # It's (remotely) possible a previous one already deleted it
      # So make sure it exists before deleting
      i = Instrument.find_by_id(id)
      unless i.nil?
        i.destroy
      end
    end
    
    redirect_to duplicate_instruments_path, :notice => 'Resolved instruments'
  end
  
  def update_effective_date
    @lookup = Instrument.find(params[:id])
    
    value = params[:effective_date].blank? ? nil : Date.strptime(params[:effective_date], '%m/%d/%Y')

    if @lookup.update_attributes(:effective_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def update_expiration_date
    @lookup = Instrument.find(params[:id])    

    value = params[:expiration_date].blank? ? nil : Date.strptime(params[:expiration_date], '%m/%d/%Y')

    if @lookup.update_attributes(:expiration_date => value)
      head :ok
    else
      render :text => @lookup.errors.full_messages.to_sentence
    end
  end
  
  def create_dup_set(field, dup_sets, set_map, max_num = 30)
    # Find sets of instruments with the same cusip and different instrument_ids
    sql = "SELECT #{field} FROM " +
          "(SELECT #{field},COUNT(*) c FROM instruments" +
          " WHERE #{field} IS NOT NULL " +
          "GROUP BY #{field}) AS Sub " +
          "WHERE c > 1 " + 
          "ORDER BY c DESC"
    
    recs = ActiveRecord::Base.connection.execute(sql)
    recs.each do |r|
      current_field = r[field]
      # We now have a CUSIP to try - eliminate ones with the same instrument_id (corporate actions)
      sql = "SELECT instrument_id FROM " +
            "(SELECT instrument_id,COUNT(*) c " +
            "FROM instruments " +
            "WHERE #{field}='#{current_field}' " +
            "GROUP BY instrument_id) AS Sub " +
            "WHERE c = 1"
      instrument_ids = []
      ids = ActiveRecord::Base.connection.execute(sql)
      ids.each do |id|
        instrument_ids.push(id['instrument_id'])
      end
      
      # Instrument ids has the list of non-duplicate instrument_ids
      # If there is only one, it was just a corporate action - no potential duplicates
      other_field = 'cusip' == field ? 'isin' : 'cusip'
      
      if instrument_ids.count > 1
        sql = "SELECT id,figi,sedol,#{other_field} FROM instruments WHERE #{field}='#{r[field]}' AND instrument_id IN (#{instrument_ids})".gsub('[','').gsub(']','')
        table = ActiveRecord::Base.connection.execute(sql)
        table.each do |row|
          dups = []
          clauses = []
          unless row['figi'].nil?
            clauses.push("(figi IS NULL OR figi='#{row['figi']}')")
          end
          unless row['sedol'].nil?
            clauses.push("(sedol IS NULL OR sedol='#{row['sedol']}')")
          end
          unless row[other_field].nil?
            clauses.push("(#{other_field} IS NULL OR #{other_field}='#{row[other_field]}')")
          end

          sql = "SELECT id FROM instruments WHERE " + clauses.join(" AND ") + " AND #{field}='#{current_field}'"
          res = ActiveRecord::Base.connection.execute(sql)
          res.each do |rx|
            dups.push(rx['id'])
          end
        
          if dups.count > 1 and not dup_sets.include?(dups)
            sql = "SELECT #{FIELDS} FROM instruments WHERE id IN (#{dups})".gsub('[','').gsub(']','')
  
            current = []
            instruments = ActiveRecord::Base.connection.execute(sql)
            instruments.each do |instrument|
              current.append(instrument)
            end
            
            dup_sets.append(current)
            set_map[dup_sets.count] = instrument_ids
            
            break if dup_sets.count >= max_num
          end
        end
        
        break if dup_sets.count >= max_num
      end
    end
  end
  
  def create_isin_cusip_set(dup_sets, set_map, max_num = 10)
    # i/s form a pair - group ones where this is equal; each set with the same glob value is a duplicate set
    dup_sql = []
   
    # We will get lines like this - lines that share the same "glob" are a potential duplicate set
    # We want to eliminate any with duplicate instrument_ids (those are corporate actions), so
    # in the example below, only the 3rd would survive - and because there's only 1, it wouldn't be
    # a set (has to be at least two, of course)
    # <isin1><cusip1>  9494 9494
    # <isin1><cusip1> 32324 9494
    # <isin1><cusip1> 63432 3234
    # <isin1><cusip2> ...
    # instrument_id => id
    sql = "SELECT CONCAT(i,s) AS glob,instrument_id,id FROM instruments " + 
          "JOIN (SELECT isin AS i,sedol AS s FROM " + 
          "(SELECT isin,sedol,COUNT(*) c FROM instruments " + 
          "WHERE figi IS NULL AND isin IS NOT NULL AND sedol IS NOT NULL " +
          "GROUP BY isin,sedol) AS Sub " +
          "WHERE c > 1 order by isin,sedol) As Sub " +
          "ON isin=i AND sedol=s ORDER BY glob"    
    process_globs(sql, dup_sql)

    sql = "SELECT CONCAT(f,i,s) AS glob,instrument_id,id FROM instruments " + 
          "JOIN (SELECT figi AS f,isin AS i,sedol AS s FROM " + 
          "(SELECT figi,isin,sedol,COUNT(*) c FROM instruments " + 
          "WHERE figi IS NOT NULL AND isin IS NOT NULL AND sedol IS NOT NULL " +
          "GROUP BY figi,isin,sedol) AS Sub " +
          "WHERE c > 1 order by figi,isin,sedol) As Sub " +
          "ON figi=f AND isin=i AND sedol=s ORDER BY glob"    
    process_globs(sql, dup_sql)

    # We're already eliminated duplicate ids, so don't need to check again here
    dup_sql.shuffle.each do |s|
      recs = ActiveRecord::Base.connection.execute(s)
      current = []
      instrument_id = nil
      
      id_set = []
      recs.each do |r|
        id_set.push(r['instrument_id'])         
        current.push(r)
      end
      
      next if current.count < 2
      
      dup_sets.push(current)
      set_map[dup_sets.count] = id_set
      
      break if dup_sets.count >= max_num
    end
  end
         
  def create_field_set(field, dup_sets, set_map, max_num = 10)
    sql = "SELECT figi,sedol,isin,cusip,#{field} FROM (SELECT figi,sedol,isin,cusip,#{field},COUNT(*) c FROM instruments GROUP BY figi,sedol,isin,cusip,#{field}) AS sub WHERE c > 1"
    dup_sql = []
    recs = ActiveRecord::Base.connection.execute(sql)
    recs.each do |rec|
      # Need at least one id!
      next if rec['figi'].blank? and rec['sedol'].blank? and rec['isin'].blank? and rec['cusip'].blank?
      
      clauses = []
      clauses.push("figi='#{rec['figi']}'") unless rec['figi'].blank?
      clauses.push("sedol='#{rec['sedol']}'") unless rec['sedol'].blank?
      clauses.push("isin='#{rec['isin']}'") unless rec['isin'].blank?
      clauses.push("cusip='#{rec['cusip']}'") unless rec['cusip'].blank?
      clauses.push("#{field}='#{rec[field]}'") unless rec[field].blank?
      
      dup_sql.push("SELECT #{FIELDS} FROM instruments WHERE " + clauses.join(" AND ") + " ORDER BY instrument_id")
    end
    
    dup_sql.each do |s|
      recs = ActiveRecord::Base.connection.execute(s)
      current = []
      instrument_id = nil
      diff_ids = false
      
      id_set = []
      recs.each do |r|
        id_set.push(r['instrument_id'])
         
        if instrument_id.nil?
          instrument_id = r['instrument_id']
        elsif r['instrument_id'] != instrument_id and (!r['effective_date'].blank? or !r['expiration_date'].blank?)
          diff_ids = true
        end
        
        current.push(r)
      end
      
      # Don't mark as duplicates if they're just effective/expiration date pairs
      
      if diff_ids and current.count > 1
        dup_sets.push(current)
        set_map[dup_sets.count] = id_set
      end
      
      break if dup_sets.count >= max_num
    end
  end

  def create_ambiguous_set(dup_sets, set_map, max_num = 10)
    rec = ActiveRecord::Base.connection.execute('SELECT MAX(file_date) AS max_date FROM ambiguous_instruments')
    max_date = rec[0]['max_date'] rescue nil
    unless max_date.nil?
      s = "SELECT DISTINCT instrument_list FROM ambiguous_instruments WHERE file_date='#{max_date}'"
      recs = ActiveRecord::Base.connection.execute(s)
      
      recs.each do |r|
        ids = r['instrument_list']
        # Make sure the list doesn't already exist
        str_id_list = ids[1,ids.length-2].gsub(' ','') rescue nil
        next if str_id_list.blank?
        str_id_set = str_id_list.split(',')
        next if 1 == str_id_set.count
        num_set = []
        str_id_set.each do |id|
          num_set.push(id.to_i)
        end
        next if 1 == num_set.count
        next if dup_sets.include?(num_set)
          
        # We have a set of instrument_ids that isn't already generated from before
        
        s = "SELECT #{FIELDS} FROM instruments WHERE instrument_id IN #{ids}"
        dups = ActiveRecord::Base.connection.execute(s)

        current = []
        dups.each do |d|
           current.push(d)
        end
      
        dup_sets.push(current)
        set_map[dup_sets.count] = num_set
        
        break if dup_sets.count >= max_num
      end
    end
  end
    
  def index
    @paginated = false
    
    if params[:id_set]
      ids = []
      params[:id_set].split(",").each do |id|
        ids.push(id.to_i)
      end
      @instruments = Instrument.order(:standard_name).find(ids)
    elsif params[:figi]
      @instruments = Instrument.where(:figi => params[:figi]).order(:standard_name)
    elsif params[:sedol]
      @instruments = Instrument.where(:sedol => params[:sedol]).order(:standard_name)
    elsif params[:isin]
      @instruments = Instrument.where(:isin => params[:isin]).order(:standard_name)
    elsif params[:cusip]
      @instruments = Instrument.where(:cusip => params[:cusip]).order(:standard_name)
    else
      @instruments = Instrument.where(:approved => false).order(:standard_name).paginate(:page => params[:page])
      @paginated = true
    end
    
    render :layout => 'admin'
  end
  
  def set_default
    instrument = Instrument.find(params[:id])
    default_set = params[:default] == 'true'
    @instruments = Instrument.where(:instrument_id => instrument.instrument_id)

    @instruments.each do |i|
      # Should be set to the opposite
      if default_set == i.default_instrument
        raise 'Inconsistent state'
      end
    end
      
    @instruments.update_all(:default_instrument => default_set)
    
    head :ok   
  end

  def set_approved
    instrument = Instrument.find(params[:id])
    approved_set = params[:approved] == 'true'
    @instruments = Instrument.where(:instrument_id => instrument.instrument_id)

    @instruments.each do |i|
      # Should be set to the opposite
      if approved_set == i.approved
        raise 'Inconsistent state'
      end
    end
      
    @instruments.update_all(:approved => approved_set)
    
    head :ok   
  end
  
private
  def process_globs(sql, dup_sql)    
    current = Hash.new
    last_glob = nil
    recs = ActiveRecord::Base.connection.execute(sql)
    recs.each do |rec|      
      # Detect glob boundaries
      if rec['glob'] != last_glob
        unless last_glob.nil?
          current_instrument_ids = Hash.new
          current_ids = []
          
          # Process a set
          # Remove any that have duplicates (same instrument_id - those would be effective/expiration dates)
          current.each do |inst_id, ids|
            if 1 == ids.length
              current_instrument_ids[inst_id] = 1
              current_ids.push(ids[0])
            end
          end
          
          if current_instrument_ids.length > 1
            dup_sql.push("SELECT #{FIELDS} FROM instruments WHERE id IN (#{current_ids.to_s.gsub(/(\[|\])/,'')})")
          end
                    
          current = Hash.new
        end
      end
        
      # instrument id 1 => [1,2]
      # instrument id 2 => [3]
      # 
      unless current.has_key?(rec['instrument_id'])
        current[rec['instrument_id']] = []
      end
      current[rec['instrument_id']].push(rec['id'])
      
      last_glob = rec['glob']
    end
  end
end
