class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer  :user_id
      t.string   :account_number
      t.decimal  :balance, precision: 15, scale: 2, default: 0.00
      t.string   :account_type
      t.timestamps
    end
  end
end
