class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer  :account_id
      t.string   :description, limit: 100
      t.string   :account_number
      t.decimal  :amount, precision: 15, scale: 2, default: 0.00
      t.string   :transaction_type
      t.timestamps
    end
  end
end
