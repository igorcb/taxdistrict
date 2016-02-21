class TablePrice < ActiveRecord::Base

	belongs_to :origin, class_name: 'District', foreign_key: 'district_origin_id'
	belongs_to :target, class_name: 'District', foreign_key: 'district_target_id'

	validates :district_origin_id, presence: true
	validates :district_target_id, presence: true
  validates :price, presence: true

	validates_uniqueness_of :district_origin_id, :scope => [:district_target_id]

  before_save :rate_exist?


	scope :confirmed, -> { where(confirmed: true) }
	scope :not_confirmed, -> { where(confirmed: false) }


	def rate_exist?
		rate = Rate.find_by_district_origin_id_and_district_target_id(self.district_origin_id, self.district_target_id)
		if rate.present?
			errors.add(:district_origin_id, " and destination are already registered or confirmed.")
		end
	end

	def confirm
    ActiveRecord::Base.transaction do
    	origin = District.find(self.district_origin_id)
    	target = District.find(self.district_target_id)
      price  = self.price
      Rate.create!(district_origin_id: self.district_origin_id, district_target_id: self.district_target_id, price: price)
      TablePrice.update(self.id, confirmed: true)
    end

	end
end
