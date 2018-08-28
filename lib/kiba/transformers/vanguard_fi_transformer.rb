class VanguardFITransformer < VanguardETFTransformer
  def process(row)
    new_row = super
    
    new_row[:basket_type] = normalize_text(row['Basket Type'], 32)
    
    new_row
  end
end
