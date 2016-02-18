class RenameIdsRates < ActiveRecord::Migration
  def self.up
    change_table :rates do |t|
      t.rename :district_origin, :district_origin_id
      t.rename :district_target, :district_target_id
    end
  end
  def self.down
    change_table :rates do |t|
      t.rename :district_origin_id, :district_origin
      t.rename :district_target_id, :district_target
    end
  end
end
