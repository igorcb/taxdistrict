class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :district_origin
      t.integer :district_target
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
