class Rate < ActiveRecord::Base
	belongs_to :origin, class_name: 'District', foreign_key: 'district_origin_id'
	belongs_to :target, class_name: 'District', foreign_key: 'district_target_id'

	validates :district_origin_id, presence: true
	validates :district_target_id, presence: true

	validates_uniqueness_of :district_origin_id, :scope => [:district_target_id]
end
