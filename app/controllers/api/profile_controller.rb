class Api::ProfileController < ApplicationController
  
  before_action :authenticate_user!
  
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, :bypass => true
      head :no_content
    else
      render json: @user.errors
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.required(:user).permit(:password, :password_conf)
    end
  
end
