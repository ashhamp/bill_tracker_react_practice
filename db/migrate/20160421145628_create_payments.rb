class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :date, null: false
      t.decimal :amount, null: false
      t.text :description
      t.belongs_to :user, null: false
      t.belongs_to :bill, null: false

      t.timestamps null: false
    end
  end
end
