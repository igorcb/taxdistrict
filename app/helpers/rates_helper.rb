module RatesHelper
	def parse_audit_rate(action, changed)
     if action = 'update' 
     	 puts "**************: " + changed["price"].to_s
     	 log = "Alterado de #{changed["price"]} para #{changed[1]}" 
     end
    log
	end
end
