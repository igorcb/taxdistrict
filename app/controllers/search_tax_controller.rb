class SearchTaxController < ApplicationController
  before_filter :authenticate_user!
  autocomplete :district, :name, :full => true

  #respond_to :html, :js

  def index
    
  end

  def search
  	origin = District.find_by_name(params[:rate][:district_origin_id].upcase) if params[:rate][:district_origin_id].present? 
  	target = District.find_by_name(params[:rate][:district_target_id].upcase) if params[:rate][:district_target_id].present?  
    @rate = Rate.find_by_district_origin_id_and_district_target_id(origin.id, target.id)
  end
end
