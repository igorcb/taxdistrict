class CreateTablePrice < ActiveRecord::Migration
  def change
    create_table :table_prices do |t|
      t.integer :district_origin_id
      t.integer :district_target_id
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
