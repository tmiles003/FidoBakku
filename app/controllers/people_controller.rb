class PeopleController < ApplicationController
  
  include PeopleHelper
  
  before_action :set_user, only: [:list, :create, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
  end
  
  # POST /people/all
  # POST /people/all.json
  def list
    @account = @user.account
    @account_users = @account.account_users
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @newUser = User.new(user_params)
    @newUser.password = gen_random_password

    respond_to do |format|
      if @newUser.save
        @user.account.users << @newUser
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render json: @newUser, status: :created }
      else
        #format.html { render action: 'new' }
        format.json { render json: @newUser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
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
      # params[:person]
      params.require(:data).permit(:email, :name, :role)
    end
end
