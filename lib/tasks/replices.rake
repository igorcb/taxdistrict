namespace :db do
	desc "Replicar dados de um bairro para outro"
	#task replice: [:district_copy, :district_origin] do
	#task :replice, [:district_copy, :district_origin] => [:environment] do |t, args|

  task :replice, [:district_copy, :district_origin] => [:environment] do |t, args|
    
    district = District.find_by_name(args[:district_copy])
    abort if district.nil?

    origem = District.find_by_name(args[:district_origin])
    abort if origem.nil? 

    #Localiza todos os bairros que tem origem no Jereissate I
    rates = Rate.where(district_origin_id: district.id)
    ActiveRecord::Base.transaction do
			rates.each do |r|
			  rate = Rate.find_by_district_origin_id_and_district_target_id(origem.id, r.target.id)
			  if rate.nil?
			    puts "Cadastra a rota Origem: #{origem.name}, Destino: #{r.target.name}, Price: #{ r.price } "
			    Rate.create!(district_origin_id: origem.id, district_target_id: r.target.id, price: r.price)
			  else
			  	puts "update Origem: #{origem.name}, Destino: #{r.target.name}, Price: #{ r.price } "
			    u = Rate.find_by_district_origin_id_and_district_target_id(origem.id, r.target.id)
			    u.price = r.price
			    u.save
			  end
	    end
		end
  end
end
