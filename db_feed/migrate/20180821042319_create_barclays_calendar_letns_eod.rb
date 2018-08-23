class CreateBarclaysCalendarLetnsEod < FeedMigrationBase[5.2]
  def change
    create_table :barclays_calendar_letns_eod do |t|
      t.string :cusip
      t.string :isin
      t.string :ticker
      t.date :date
      t.string :name
      t.decimal :indicative_value
      t.integer :shares_outstanding
      t.decimal :index_value
      t.decimal :coupon
      t.decimal :market_capitalization
      t.decimal :closing_participation
      t.decimal :closing_note_financing_level
      t.decimal :closing_note_t_bills_amount
      t.decimal :closing_note_index_exposure
      t.decimal :next_closing_note_financing_level
      t.decimal :next_closing_note_t_bills_amount
      t.decimal :equity_allocation
      t.decimal :vol_allocation
      t.decimal :short_vxx_shares
      t.decimal :vxx_closing_nav
      t.decimal :accrued_fees
      t.decimal :accrued_interest
      t.date :etfg_date
    end
  end
end
