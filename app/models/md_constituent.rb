class MdConstituent < EtfgDbBase
  def self.get_ticker(instrument_exception)
    entries = instrument_exception.datasource_lines.split('~')
    entries.each do |e|
      fields = e.split(',')
      raise "Invalid datasource_lines: #{lines}" unless 2 == fields.count
      
      ds_line = fields[1]
      
      sql = "SELECT md_sponsor,md_composite_ticker,md_composite_name,md_constituent_ticker FROM import.masterdatareports_" + 
            "#{instrument_exception.file_date.try(:strftime, '%Y%m%d')} WHERE id=#{ds_line}"
      result = MdConstituent.connection.execute(sql)
      
      if 1 == result.ntuples
        row = result[0]
        return {:issuer => row['md_sponsor'],
                :composite_ticker => row['md_composite_ticker'],
                :composite_name => row['md_composite_name'],
                :constituent_ticker => row['md_constituent_ticker']}
      end
    end
  end
end
