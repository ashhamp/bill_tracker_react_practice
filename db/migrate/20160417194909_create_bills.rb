class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :nickname, null: false
      t.date :start_due_date, null: false
      t.string :url
      t.decimal :recurring_amt
      t.boolean :one_time, null: false, default: false
      t.date :next_due_date
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
