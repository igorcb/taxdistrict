class TablePricesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_table_price, only: [:show, :edit, :update, :destroy, :confirm]
  autocomplete :district, :name, :full => true
  before_filter :load_all

  #respond_to :html, :js, :json

  def index
    @table_price = TablePrice.new
  end

  def create
    @table_price = TablePrice.new
    origin = District.find_by_name(params[:table_price][:district_origin_id].upcase) if params[:table_price][:district_origin_id].present? 
    target = District.find_by_name(params[:table_price][:district_target_id].upcase) if params[:table_price][:district_target_id].present?  
    @table_price.district_origin_id = origin.id
    @table_price.district_target_id = target.id
    @table_price.price = params[:table_price][:price].to_f
    if @table_price.save
      #
    else
      @table_price.errors.full_messages.each do |msg|
        flash[:danger] = msg  
      end
    end

  end

  def destroy
    @table_price.destroy
    respond_to :js
  end

  def confirm
    @table_price.confirm
    redirect_to table_prices_path
  end

  private
    def set_table_price
      @table_price = TablePrice.find(params[:id])
    end

    def table_price_params
      params.require(:table_price).permit(:district_origin_id, :district_target_id, :price)
    end

    def load_all
      @table_prices = TablePrice.not_confirmed
    end

end
