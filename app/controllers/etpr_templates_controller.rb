require 'csv'

class EtprTemplatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @template = EtprTemplate.new(template_params)
    ok = @template.save
    if ok
      if @template.template_file.file.nil?
        @template.errors.add(:base, "ETPR template file invalid") 
        ok = false
      end
    end

    if ok
      num_found = 0
      updates = 0
      errors = 0
      created = 0
            
      # Need to clean up non-ASCII characters
      perl_output = `perl -pi -e 's/[^[:ascii:]]//g' #{@template.template_file.file.path}`
      puts perl_output
      
      today = Date.today
      
      # Read the file and set it
      CSV.foreach(@template.template_file.file.path, :headers => true) do |row|
        found = false
        # Reject blank lines
        next if row[0].blank?
        
        begin
          country = row[37].blank? ? 'US' : row[37].strip
          
          as_of_date = parse_date(row[39]) rescue today
          composites = PooledInstrument.date_range(as_of_date).where(:composite_ticker => row[0], :exchange_country => country, :exclude_from_ts => false)

          if 0 == composites.count
            next if row[1].blank?
            
            # create instrument
            issuer_name = nil
            issuer_id = nil
            unless row[2].blank?
              issuer_name = row[2]
              issuer = Issuer.find_by_name(issuer_name)
              unless issuer.nil?
                issuer_id = issuer.id
              end
              updates += 1
            end
            name = row[1].strip
            inception_date = parse_date(row[3]) 
            maturity_date = parse_date(row[5])
            
            pi = PooledInstrument.create(:issuer => issuer_name,
                                         :issuer_id => issuer_id,
                                         :composite_ticker => row[0],
                                         :composite_name_variants => name,
                                         :standard_composite_name => name,
                                         :exchange_country => country,
                                         :inception_date => inception_date,
                                         :fiscal_year_end => row[4].blank? ? nil : row[4].strip,
                                         :maturity_date => maturity_date,
                                         :listing_exchange => row[6].blank? ? nil : row[6].strip,
                                         :distribution_frequency => row[7].blank? ? nil : row[7].strip,
                                         :creation_unit_size => row[8].blank? ? nil : row[8].to_f,
                                         :creation_fee => row[9].blank? ? nil : row[9].to_f,
                                         :administrator => row[10].blank? ? nil : row[10].strip,
                                         :advisor => row[11].blank? ? nil : row[11].strip,
                                         :custodian => row[12].blank? ? nil : row[12].strip,
                                         :distributor => row[13].blank? ? nil : row[13].strip,
                                         :futures_commission_merchant => row[14].blank? ? nil : row[14].strip,
                                         :portfolio_manager => row[15].blank? ? nil : row[15].strip,
                                         :subadvisor => row[16].blank? ? nil : row[16].strip,
                                         :transfer_agent => row[17].blank? ? nil : row[17].strip,
                                         :trustee => row[18].blank? ? nil : row[18].strip,
                                         :tax_classification => row[19].blank? ? nil : row[19].strip,
                                         :management_fee => row[20].blank? ? nil : row[20].to_f,
                                         :other_expenses => row[21].blank? ? nil : row[21].to_f,
                                         :total_expenses => row[22].blank? ? nil : row[22].to_f,
                                         :fee_waivers => row[23].blank? ? nil : row[23].to_f,
                                         :net_expenses => row[24].blank? ? nil : row[24].to_f,
                                         :is_active => parse_boolean(row[25]),
                                         :is_etn => parse_boolean(row[26]),
                                         :is_levered => parse_boolean(row[27]),
                                         :levered_amount => row[28].blank? ? nil : row[28].to_f,
                                         :is_inverse => parse_boolean(row[29]),
                                         :has_derivatives => parse_boolean(row[30]),
                                         :asset_class => row[31].blank? ? nil : row[31].strip,
                                         :development_class => row[32].blank? ? nil : row[32].strip,
                                         :focus => row[33].blank? ? nil : row[33].strip,
                                         :region => row[34].blank? ? nil : row[34].strip,
                                         :category => row[35].blank? ? nil : row[35].strip,
                                         :primary_benchmark => row[38].blank? ? nil : row[38].strip,
                                         :approved => true)
            pi.update_attribute(:pooled_instrument_id, pi.id)
            created += 1
            EtprLog.create(:upload_date => today,
                           :composite_ticker => pi.composite_ticker,
                           :exchange_country => pi.exchange_country,
                           :result => "Created #{pi.id}")
          elsif 1 == composites.count            
            pi = composites.first
            found = true
            changes = {}
            # 1 issue_name
            unless row[1].blank?
              changes[:composite_description] = row[1]
              changes[:standard_composite_name] = row[1]
              updates += 1
            end
            # 2 issuer_name
            unless row[2].blank?
              changes[:issuer] = row[2]
              issuer = Issuer.find_by_name(row[2])
              unless issuer.nil?
                changes[:issuer_id] = issuer.id
              end
              updates += 1
            end
            # 3 inception_date
            unless row[3].blank?
              inception_date = parse_date(row[3])
              unless inception_date.nil?
                changes[:inception_date] = inception_date
                updates += 1
              end
            end
            # 4 fiscal_year_end
            unless row[4].blank?
              changes[:fiscal_year_end] = row[4].strip
              updates += 1
             end
            # 5 maturity_date
            unless row[5].blank?
              maturity_date = parse_date(row[5])
              unless maturity_date.nil?
                changes[:maturity_date] = maturity_date
                updates += 1
              end
            end
            # 6 listing_exchange
            unless row[6].blank?
              changes[:listing_exchange] = row[6].strip
              updates += 1
            end
            # 7 distribution_frequency
            unless row[7].blank?
              changes[:distribution_frequency] = row[7].strip
              updates += 1
            end
            # 8 creation_unit_size
            unless row[8].blank?
              changes[:creation_unit_size] = row[8].to_f
              updates += 1
            end
            # 9 creation_fee
            unless row[9].blank?
              changes[:creation_fee] = row[9].to_f
              updates += 1
            end
            # 10 administrator
            unless row[10].blank?
              changes[:administrator] = row[10].strip
              updates += 1
            end
            # 11 advisor
            unless row[11].blank?
              changes[:advisor] = row[11].strip
              updates += 1
            end
            # 12 custodian
            unless row[12].blank?
              changes[:custodian] = row[12].strip
              updates += 1
            end
            # 13 distributor
            unless row[13].blank?
              changes[:distributor] = row[13].strip
              updates += 1
            end
            # 14 futures_commission_merchant
            unless row[14].blank?
              changes[:futures_commission_merchant] = row[14].strip
              updates += 1
            end
            # 15 portfolio_manager
            unless row[15].blank?
              changes[:portfolio_manager] = row[15].strip
              updates += 1
            end
            # 16 subadvisor
            unless row[16].blank?
              changes[:subadvisor] = row[16].strip
              updates += 1
            end
            # 17 transfer_agent
            unless row[17].blank?
              changes[:transfer_agent] = row[17].strip
              updates += 1
            end
            # 18 trustee
            unless row[18].blank?
              changes[:trustee] = row[18].strip
              updates += 1
            end
            # 19 tax_classification
            unless row[19].blank?
              changes[:tax_classification] = row[19].strip
              updates += 1
            end
            # 20 management_fee
            unless row[20].blank?
              changes[:management_fee] = row[20].to_f
              updates += 1
            end
            # 21 other_expenses
            unless row[21].blank?
              changes[:other_expenses] = row[21].to_f
              updates += 1
            end
            # 22 total_expenses
            unless row[22].blank?
              changes[:total_expenses] = row[22].to_f
              updates += 1
            end
            # 23 fee_waivers
            unless row[23].blank?
              changes[:fee_waivers] = row[23].to_f
              updates += 1
            end
            # 24 net_expenses  
            unless row[24].blank?
              changes[:net_expenses] = row[24].to_f
              updates += 1
            end
            # 25 is_active
            unless row[25].blank?
              changes[:is_active] = parse_boolean(row[25])
              updates += 1
            end
            # 26 is_etn
            unless row[26].blank?
              changes[:is_etn] = parse_boolean(row[26])
              updates += 1
            end
            # 27 is_levered
            unless row[27].blank?
              changes[:is_levered] = parse_boolean(row[27])
              updates += 1
            end
            # 28 levered_amount  
            unless row[28].blank?
              changes[:levered_amount] = row[28].to_f
              updates += 1
            end
            # 29 is_inverse
            unless row[29].blank?
              changes[:is_inverse] = parse_boolean(row[29])
              updates += 1
            end
            # 30 has_derivatives
            unless row[30].blank?
              changes[:has_derivatives] = parse_boolean(row[30])
              updates += 1
            end
            # 31 asset_class
            unless row[31].blank?
              changes[:asset_class] = row[31].strip
              updates += 1
            end
            # 32 development_class
            unless row[32].blank?
              changes[:development_class] = row[32].strip
              updates += 1
            end
            # 33 focus
            unless row[33].blank?
              changes[:focus] = row[33].strip
              updates += 1
            end
            # 34 region
            unless row[34].blank?
              changes[:region] = row[34].strip
              updates += 1
            end
            # 35 category
            unless row[35].blank?
              changes[:category] = row[35].strip
              updates += 1
            end
            # 36 expiration_date
            expiration_date = parse_date(row[36]) rescue nil
            # Don't update if there's a conflict
            if not expiration_date.nil? and (pi.effective_date.nil? or pi.effective_date < expiration_date)
              changes[:expiration_date] = expiration_date
              updates += 1
            else
              EtprLog.create(:upload_date => today,
                             :composite_ticker => row[0],
                             :exchange_country => country,
                             :result => "Conflict - cannot update date '#{expiration_date}'")
              errors += 1
            end
            
            # 37 country
            unless row[37].blank?
              changes[:exchange_country] = row[37].strip
              updates += 1
            end
            # 38 primary_benchmark
            unless row[38].blank?
              changes[:primary_benchmark] = row[38].strip
              updates += 1
            end
            # 39 has as_of_date, used to disambiguate
            
            pi.update_attributes(changes)
          else
            errors += 1
            EtprLog.create(:upload_date => today,
                           :composite_ticker => row[0],
                           :exchange_country => country,
                           :result => "Ambiguous pooled instrument!")
          end
          
          num_found += 1 if found
        rescue Exception => ex
          errors += 1

          EtprLog.create(:upload_date => today,
                         :composite_ticker => row[0],
                         :exchange_country => country,
                         :result => "Exception! #{ex.message}\n #{ex.backtrace.join('\n')}")          
        end
      end
      
      stats = "#{num_found} found; #{updates} updated; #{created} created; #{errors} errors;"
      
      redirect_to root_path, :notice => "ETPR template file uploaded (#{stats})"
    else
      redirect_to templates_path, :alert => @template.errors.full_messages.to_sentence
    end
  end
  
private
  def parse_boolean(val)
    return val.blank? ? false : ['y','yes','t','true','1'].include?(val.downcase)
  end
  
  def parse_date(str)
    result = nil

    fields = str.split(/\//)
    if 3 == fields.length
      fmt = 2 == fields[2].length ? "%m/%d/%y" : "%m/%d/%Y"
      result = Date.strptime(str, fmt)
    end    
    
    result
  end
  
  def template_params
    params.require(:etpr_template).permit(:user_id, :template_file)
  end
end
