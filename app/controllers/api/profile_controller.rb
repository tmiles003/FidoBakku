class Api::ProfileController < Api::ApiController
  
  prepend_before_filter :set_user, only: [:update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  
  def update
    if @user.update(passwd_params)
      sign_in @user, :bypass => true
      head :no_content, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def passwd_params
      params.required(:profile).permit(:password, :password_confirmation)
    end
    
    def set_user
      @user = ::User.find(current_user.id) unless current_user.nil?
    end
  
    def invalid_user
      logger.error "No user with this id: nil"
      error = Hash['error', [t('admin.users.record_not_found')]]
      render json: error, status: :not_found
    end

end
