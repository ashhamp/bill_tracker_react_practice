class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :pmt_date, null: false
      t.decimal :pmt_amt, null: false
      t.text :description
      t.belongs_to :user
      t.belongs_to :bill

      t.timestamps null: false
    end
  end
end
