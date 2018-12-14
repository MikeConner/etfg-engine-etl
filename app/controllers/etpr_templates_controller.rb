require 'csv'

class EtprTemplatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @template = EtprTemplate.new(template_params)
    if @template.save
      num_not_found = 0
      num_found = 0
      updates = 0
      errors = 0
      created = 0
      
      # Need to clean up non-ASCII characters
      perl_output = `perl -pi -e 's/[^[:ascii:]]//g' #{@template.template_file.file.path}`
      puts perl_output
      
      # Read the file and set it
      CSV.foreach(@template.template_file.file.path, :headers => true) do |row|
        found = false
        begin
          pi = PooledInstrument.find_by_composite_ticker_and_exchange_country(row[0], 'US')
          if pi.nil?
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
            inception_date =  Date.strptime(row[3], "%m/%d/%y") rescue nil
            fiscal_year_end = Date.strptime(row[4], "%m/%d/%y") rescue nil
            maturity_date = Date.strptime(row[5], "%m/%d/%y") rescue nil
            
            pi = PooledInstrument.create(:issuer => issuer_name,
                                         :issuer_id => issuer_id,
                                         :composite_ticker => row[0],
                                         :composite_name_variants => name,
                                         :standard_composite_name => name,
                                         :exchange_country => 'US',
                                         :inception_date => inception_date,
                                         :fiscal_year_end => fiscal_year_end,
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
                                         :is_active => ActiveModel::Type::Boolean.new.cast(row[25]),
                                         :is_etn => ActiveModel::Type::Boolean.new.cast(row[26]),
                                         :is_levered => ActiveModel::Type::Boolean.new.cast(row[27]),
                                         :levered_amount => row[28].blank? ? nil : row[28].to_f,
                                         :is_inverse => ActiveModel::Type::Boolean.new.cast(row[29]),
                                         :has_derivatives => ActiveModel::Type::Boolean.new.cast(row[30]),
                                         :asset_class => row[31].blank? ? nil : row[31].strip,
                                         :development_class => row[32].blank? ? nil : row[32].strip,
                                         :focus => row[33].blank? ? nil : row[33].strip,
                                         :region => row[34].blank? ? nil : row[34].strip,
                                         :approved => true)
            pi.update_attribute(:pooled_instrument_id, pi.id)
            created += 1
          else
            PooledInstrument.where(:pooled_instrument_id => pi.pooled_instrument_id).each do |c|
              found = true
              changes = {}
              # 1 issue_name
              unless row[1].blank?
                changes[:composite_description] = row[1]
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
                inception_date = Date.strptime(row[3], "%m/%d/%y") rescue nil
                unless inception_date.nil?
                  changes[:inception_date] = inception_date
                  updates += 1
                end
              end
              # 4 fiscal_year_end
              unless row[4].blank?
                fiscal_year = Date.strptime(row[4], "%m/%d/%y") rescue nil
                unless fiscal_year.nil?
                  changes[:fiscal_year_end] = fiscal_year
                  updates += 1
                end
              end
              # 5 maturity_date
              unless row[5].blank?
                maturity_date = Date.strptime(row[5], "%m/%d/%y") rescue nil
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
                changes[:is_active] = ActiveModel::Type::Boolean.new.cast(row[25])
                updates += 1
              end
              # 26 is_etn
              unless row[26].blank?
                changes[:is_etn] = ActiveModel::Type::Boolean.new.cast(row[26])
                updates += 1
              end
              # 27 is_levered
              unless row[27].blank?
                changes[:is_levered] = ActiveModel::Type::Boolean.new.cast(row[27])
                updates += 1
              end
              # 28 levered_amount  
              unless row[28].blank?
                changes[:levered_amount] = row[28].to_f
                updates += 1
              end
              # 29 is_inverse
              unless row[29].blank?
                changes[:is_inverse] = ActiveModel::Type::Boolean.new.cast(row[29])
                updates += 1
              end
              # 30 has_derivatives
              unless row[30].blank?
                changes[:has_derivatives] = ActiveModel::Type::Boolean.new.cast(row[30])
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
  
              c.update_attributes(changes)
            end
          end
          
          if found
            num_found += 1
          else
            num_not_found += 1
            puts "#{row[0]} not found"
          end
        rescue Exception => ex
          errors += 1
          
          puts ex.message
          puts row
        end
      end
      
      stats = "#{num_found} found; #{num_not_found} not found; #{updates} updated; #{created} created; #{errors} errors"
      
      redirect_to root_path, :notice => "ETPR template file uploaded (#{stats})"
    else
      flash.now[:alert] = @template.errors.full_messages.to_sentence
      render templates_path, :layout => 'admin'
    end
  end
  
private
  def template_params
    params.require(:etpr_template).permit(:user_id, :template_file)
  end
end
