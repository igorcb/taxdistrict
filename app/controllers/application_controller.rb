class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_logger_username

  def after_sign_in_path_for(resource)
    search_tax_index_path
  end


	def set_logger_username
	  Thread.current["username"] = current_user.email || "guest"
	  yield
	  Thread.current["username"] = nil
	end  
end
