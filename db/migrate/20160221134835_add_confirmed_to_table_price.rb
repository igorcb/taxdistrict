class AddConfirmedToTablePrice < ActiveRecord::Migration
  def change
    add_column :table_prices, :confirmed, :boolean, default: false
  end
end
