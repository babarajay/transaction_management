class CreateAmas < ActiveRecord::Migration[5.1]
  def change
    create_table :amas do |t|
      t.string   :title, limit: 100
      t.bigint   :speaker_id
      t.datetime :start_date
      t.integer  :state, default: 1

      t.timestamps
    end
  end
end
