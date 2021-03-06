require 'iconv'
class RatesController < ApplicationController
  BOM = "\377\376" #Byte Order Mark
  before_filter :authenticate_user!
  before_action :set_rate, only: [:show, :edit, :update, :destroy]

  def rate_import
  end

  def import
    Rate.import(params[:origin_id], params[:file])
    redirect_to search_tax_index_path, flash: { success: 'Tabela importada com sucesso.' }
  end

  # GET /rates
  # GET /rates.json
  def index
    #@rates = Rate.paginate(page: params[:page])
    #@rates = Rate.joins(:origin, :target).order('districts.name asc')
    #@rates = Rate.all
    @rates = Rate.joins(:origin, :target).order('districts.name asc, targets_rates.name asc')
    filename = "tabela_de_preco.xls"
    respond_to do |format|
      format.html
      #format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" }
      format.csv { export_csv(@rates) }
      #format.csv { render text: @rates.to_csv }
    end
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new(rate_params)
    origin = District.find_by_name(params[:rate][:district_origin_id].upcase) if params[:rate][:district_origin_id].present? 
    target = District.find_by_name(params[:rate][:district_target_id].upcase) if params[:rate][:district_target_id].present?  
    @rate.district_origin_id = origin.id
    @rate.district_target_id = target.id
    respond_to do |format|
      if @rate.save
        format.html { redirect_to @rate, flash: { success: 'Rate was successfully created.' } }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { redirect_to rates_new_path }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to @rate, flash: { success: 'Rate was successfully updated.' } }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: 'Rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:district_origin_id, :district_target_id, :price)
    end

    def export_csv(rates)
      #filename = I18n.l(Time.now, :format => :short) + "- TabelePreco.csv"
      filename = "TabelePreco.csv"
      content = rates.to_csv
      #content = BOM + Iconv.conv("utf-16le", "utf-8", content)
      send_data content, :filename => filename
    end

end
