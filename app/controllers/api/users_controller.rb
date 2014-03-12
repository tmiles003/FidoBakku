class Api::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_user, only: [:edit, :update, :destroy]
  
  include UsersHelper
  
  # GET /api/users
  # GET /api/users.json
  def index
    @account = @current_user.account
    @account_users = @account.account_users
  end

  # GET /api/users/list
  # GET /api/users/list.json
  def list
    @account = @current_user.account
    @users = @account.account_users
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @new_user = ::User.new(user_params) # :: forces root namespace
    @new_user.password = gen_random_password

    respond_to do |format|
      if @new_user.save
        @current_user.account.users << @new_user
        format.json { render json: @new_user, status: :created }
      else
        format.json { render json: @new_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/users/1
  # PATCH/PUT /api/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/users/1
  # DELETE /api/users/1.json
  def destroy
    @user.destroy # unless @user.id != @current_user.id
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user
      @current_user = current_user
    end
    
    def set_user
      @user = ::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :role)
    end
end
