class PeopleController < ApplicationController
  
  include PeopleHelper
  
  # GET /people
  def index
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
