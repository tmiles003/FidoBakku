class Api::UsersController < ApplicationController
  
  include PeopleHelper
  
  before_action :set_user

  # GET /api/users
  # GET /api/users.json
  def index
    @account = @user.account
    @account_users = @account.account_users
  end

  # GET /api/users/1
  # GET /api/users/1.json
  def show
  end

  # GET /api/users/1/edit
  def edit
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @newUser = User.new(user_params)

    respond_to do |format|
      if @newUser.save
        @user.account.users << @newUser
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :role)
    end
end
