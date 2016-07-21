class AddUserToRates < ActiveRecord::Migration
  def change
    add_reference :rates, :user, index: true, foreign_key: true
  end
end
