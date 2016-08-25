module RatesHelper
	def parse_audit_rate(action, changed)
     if action = 'update' 
     	 #puts "**************: " + changed
     	 log = "Alterado de #{changed['price'][0]} para #{changed['price'][1]}" 
     	 
     end
    log
	end

	def parse_audit_email(user)
		user.present? ? user.email : 'alterado pelo sistema' 
	end
end
