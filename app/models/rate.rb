class Rate < ActiveRecord::Base
	belongs_to :origin, class_name: 'District', foreign_key: 'district_origin_id'
	belongs_to :target, class_name: 'District', foreign_key: 'district_target_id'

	validates :district_origin_id, presence: true
	validates :district_target_id, presence: true
  validates :price, presence: true
  
	validates_uniqueness_of :district_origin_id, :scope => [:district_target_id], if: :diff_origin_and_target?

  scope :origin_and_target, -> { joins(:origin, :target).order('districts.name asc') }
	
  after_save :modifi_price_invert_rate

  def diff_origin_and_target?
    district_origin_id !=  district_target_id
  end

  def modifi_price_invert_rate
    #procura pela rota invertida
    rate_invert = Rate.find_by_district_origin_id_and_district_target_id(self.district_target_id, self.district_origin_id)
    #cadastra ou atualiza o preco da rota invertida a rota
    if rate_invert.nil?
    	Rate.create!(district_origin_id: self.district_target_id, district_target_id: self.district_origin_id, price: price) 
    else
      Rate.where(id: rate_invert.id).update_all(price: self.price)    	
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ["Origem", "Destino", "Valor"]
      all.each do |rate|
        row = [rate.origin.name, rate.target.name, rate.price.to_f]
        csv << row
      end
    end
  end 


end
