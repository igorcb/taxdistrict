module RatesHelper
	def parse_audit_rate(action, changed)
     if action == 'create'
        log = "criado com o valor: #{changed['price']}" 
     elsif action =='update' 
     	 log = "Alterado de #{changed['price'][0]} para #{changed['price'][1]}" 
     end
    log
	end

	def parse_audit_email(user)
		user.present? ? user.email : 'alterado pelo sistema' 
	end
end


#{"district_origin_id"=>329, "district_target_id"=>176, "price"=>25}
