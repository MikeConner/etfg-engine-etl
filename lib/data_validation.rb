# frozen_string_literal: true

module DataValidation   
  def cleanup_data(data)
    data.match?(/=\"(.*)\"/) ? data.match(/=\"(.*)\"/)[1] : data
  end
   
  def normalize_text(value, max_len)
    return nil if value.blank?
        
    result = value.sub(/\A( |\t|'|\.|-)/, '').rstrip
    
    return nil if result.blank? or result.length > max_len
        
    # Final step to remove trademark/copyright, etc.
    result.sub(/[^\x00-\x7F]+/,'')    
  end
  
  def normalize_ticker(value, max_len = 64)
    return nil if value.blank?
    
    result = value.sub(/\A( |\t|'|\r|\n|-)/, '').rstrip
    
    return nil if result.blank? or result.length > max_len

    result    
  end
  
  def normalize_date(value, fmt)
    return nil if value.blank?
    return value if Date == value.class
    
    dval = normalize_ticker(value)
    
    dval.nil? ? nil : Date.strptime(dval, fmt) rescue nil
  end
  
  def normalize_float(value)
    return value if value.nil? or (Float == value.class)
    
    return nil if value.blank? or value.sub(/-/, '').blank?
    
    value.to_f rescue nil  
  end
  
  def normalize_figi(value)
    figi = normalize_ticker(value)
    
    (!figi.blank? and is_valid_figi(figi)) ? figi : nil    
  end
  
  def normalize_sedol(value)
    sedol = normalize_ticker(value)
    
    (!sedol.blank? and is_valid_sedol(sedol)) ? sedol : nil    
  end
  
  def normalize_isin(value)
    isin = normalize_ticker(value)
    
    (!isin.blank? and is_valid_isin(isin)) ? isin : nil    
  end
  
  def normalize_cusip(value)
    cusip = normalize_ticker(value)
    
    (!cusip.blank? and is_valid_cusip(cusip)) ? cusip : nil    
  end

  def is_valid_cusip(cusip)
    cusip = SecurityIdentifiers::CUSIP.new(cusip)
    cusip.valid? rescue false
  end

  def is_valid_isin(isin)
    isin = SecurityIdentifiers::ISIN.new(isin)
    isin.valid? rescue false
  end

  def is_valid_sedol(sedol)
    sedol = SecurityIdentifiers::SEDOL.new(sedol)
    sedol.valid? 
  rescue Exception => ex
    puts ex.message
  end    
end
