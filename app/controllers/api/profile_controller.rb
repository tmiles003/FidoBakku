class Api::ProfileController < Api::ApiController
  
  def update
    @user = ::User.find(current_user.id)
    logger.info @user.to_yaml
    if @user.update(passwd_params)
      sign_in @user, :bypass => true
      head :no_content
    else
      render json: @user.errors
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def passwd_params
      params.required(:profile).permit(:password, :password_confirmation)
    end
  
end
