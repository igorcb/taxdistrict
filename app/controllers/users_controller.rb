class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :user_admin
    

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was succefully created!' }
      else
        format.html { render :action => :new }
      end
    end
  end

  # PUT /users/1
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, :notive => 'User was successfuly updated!' }
      else
        format.html { render :action => :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end

    def user_admin
      unless current_user.admin?
        flash[:warning] = 'You have no access to users'
        redirect_to(search_tax_index_path)
      end
    end

end
