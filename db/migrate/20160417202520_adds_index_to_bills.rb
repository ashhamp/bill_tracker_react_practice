class AddsIndexToBills < ActiveRecord::Migration
  def change
    add_index :bills, [:nickname, :user_id], unique: true, using: :btree
  end
end
