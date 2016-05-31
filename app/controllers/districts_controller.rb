class DistrictsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_district, only: [:show, :edit, :update, :destroy]

  autocomplete :district, :name, full: true, limit: 20
  #respond_to :html

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.order(:name)
    filename = "district.xls"
    respond_to do |format|
      format.html
      format.xls #{ headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" }
    end
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
    filename = "#{@district.name}.xls"
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" }
    end
  end

  # GET /districts/new
  def new
    @district = District.new
  end

  # GET /districts/1/edit
  def edit
  end

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)

    respond_to do |format|
      if @district.save
        format.html { redirect_to @district, flash: { success: 'District was successfully created.' } }
        format.json { render :show, status: :created, location: @district }
      else
        format.html { render :new }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /districts/1
  # PATCH/PUT /districts/1.json
  def update
    respond_to do |format|
      if @district.update(district_params)
        format.html { redirect_to @district, flash: { success: 'District was successfully updated.' } }
        format.json { render :show, status: :ok, location: @district }
      else
        format.html { render :edit }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    # @district.destroy
    #   respond_to do |format|
    #     format.html { redirect_to districts_url, flash: { success: 'District was successfully destroyed.' } }
    #     format.json { head :no_content }
    #   end

    if @district.destroy
      respond_to do |format|
        format.html { redirect_to districts_url, flash: { success: 'District was successfully destroyed.' } }
        format.json { head :no_content }
      end
    else
      @district.errors.full_messages.each do |msg|
        flash[:danger] = msg  
      end
      redirect_to districts_url   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def district_params
      params.require(:district).permit(:name)
    end
end
