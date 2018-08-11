module BMOHelper
  # returns ticker, country tuple, given a raw ticker input
  # if there is no country, country will be nil
  def parse_ticker_country(value)
    return nil, nil if value.blank?
    
    if value.upcase =~ / [A-Z]{2}\Z/ 
      return value[0..(value.length - 4)], value.upcase.last(2) 
    else
      return value, nil
    end
  end
end