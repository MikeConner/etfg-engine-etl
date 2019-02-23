class InstrumentsController < ApplicationController
  respond_to :js, :html

  NUM_DUPLICATES = 30
    
  before_action :authenticate_user!

  def duplicate
    @source_map = Hash.new
    Datasource.all.each do |d|
      @source_map[d.id] = d.data_source_name
    end
    
    @dup_sets = []
    @set_map = {}
    
    create_isin_cusip_set(@dup_sets, @set_map)
    create_field_set('exchange_country', @dup_sets, @set_map, 20)
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
      
      Instrument.find(id).destroy
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
  
  def create_isin_cusip_set(dup_sets, set_map, max_num = 10)
    fields = 'id,instrument_id,datasource_id,ticker,standard_name,effective_date,expiration_date,figi,sedol,isin,cusip,exchange_country,currency,exchange,approved,default_instrument'
    # i/s form a pair - group ones where this is equal; each set with the same glob value is a duplicate set
    sql = "SELECT CONCAT(i,s) AS glob,instrument_id,id FROM instruments " + 
          "JOIN (SELECT isin AS i,sedol AS s FROM " + 
          "(SELECT isin,sedol,COUNT(*) c FROM instruments GROUP BY isin,sedol) AS Sub " +
          "WHERE c > 1 order by isin,sedol) As Sub " +
          "ON isin=i AND sedol=s ORDER BY glob"    
    dup_sql = []
    recs = ActiveRecord::Base.connection.execute(sql)
    last_glob = nil
   
    # We will get lines like this - lines that share the same "glob" are a potential duplicate set
    # We want to eliminate any with duplicate instrument_ids (those are corporate actions), so
    # in the example below, only the 3rd would survive - and because there's only 1, it wouldn't be
    # a set (has to be at least two, of course)
    # <isin1><cusip1>  9494 9494
    # <isin1><cusip1> 32324 9494
    # <isin1><cusip1> 63432 3234
    # <isin1><cusip2> ...
    # instrument_id => id
    current = Hash.new
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
            dup_sql.push("SELECT #{fields} FROM instruments WHERE id IN (#{current_ids.to_s.gsub(/(\[|\])/,'')})")
          end
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
    
    # We're already eliminated duplicate ids, so don't need to check again here
    dup_sql.each do |s|
      recs = ActiveRecord::Base.connection.execute(s)
      current = []
      instrument_id = nil
      
      id_set = []
      recs.each do |r|
        id_set.push(r['instrument_id'])         
        current.push(r)
      end
      
      dup_sets.push(current)
      set_map[dup_sets.count] = id_set
      
      break if dup_sets.count >= max_num
    end
  end
         
  def create_field_set(field, dup_sets, set_map, max_num = 10)
    fields = 'id,instrument_id,datasource_id,ticker,standard_name,effective_date,expiration_date,figi,sedol,isin,cusip,exchange_country,currency,exchange,approved,default_instrument'
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
      
      dup_sql.push("SELECT #{fields} FROM instruments WHERE " + clauses.join(" AND ") + " ORDER BY instrument_id")
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
      
      if diff_ids
        dup_sets.push(current)
        set_map[dup_sets.count] = id_set
      end
      
      break if dup_sets.count >= max_num
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
end
