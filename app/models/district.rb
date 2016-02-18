class District < ActiveRecord::Base
	has_many :origins, class_name: 'Rate', foreign_key: 'district_origin_id'
	has_many :targets, class_name: 'Rate', foreign_key: 'district_target_id'

	validates :name, presence: true, uniqueness: true, length: { maximum: 250 }
  
  before_save { |district| district.name = name.upcase } 
end
