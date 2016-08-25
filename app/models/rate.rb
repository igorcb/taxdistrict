class Rate < ActiveRecord::Base
	belongs_to :origin, class_name: 'District', foreign_key: 'district_origin_id'
	belongs_to :target, class_name: 'District', foreign_key: 'district_target_id'

	validates :district_origin_id, presence: true
	validates :district_target_id, presence: true
  validates :price, presence: true
  
	validates_uniqueness_of :district_origin_id, :scope => [:district_target_id], if: :diff_origin_and_target?

  scope :origin_and_target, -> { joins(:origin, :target).order('districts.name asc') }
	
  before_save :set_values_price
  after_save :modifi_price_invert_rate


  audited
  
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
      #verifica usuario para log do sistema
      #user = find_current_user
      #if user.nil?
      user = User.find_by_email('servoscidade@servostaxi.com.br') 
      #end
      puts ">>>>>>>>>>. user: #{user.id}"
      # cadastra log
      rate_invert.audits.create!(auditable_type: "Rate", user_id: user.id, user_type: "User", action: "update", audited_changes: @price_modify, version: count_version_audited(rate_invert) )
    end
  end

  def set_values_price
     #+ JSON.parse(self.changes['price'].to_json)]
     @price_modify = {"price" => self.changes['price']}
     #puts ">>>>>>>>>>>>>> parse: #{parse.class}"
     #parse = JSON.parse(@price_modify)
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

  def find_current_user
  (1..Kernel.caller.length).each do |n|
    RubyVM::DebugInspector.open do |i|
      current_user = eval "current_user rescue nil", i.frame_binding(n)
      return current_user unless current_user.nil?
    end
  end
  return nil
  end

  private
    def count_version_audited(rate)
      rate.audits.count
    end


end
