class Api::Admin::FormUsersController < Api::Admin::ApiController
  
  authorize_resource
  
  before_action :set_form_user, only: [:update]
  
  # PATCH/PUT /api/admin/forms/1.json
  def update
    if @form_user.update(form_user_params)
      render json: @form_user, serializer: ::Admin::Form::FormUserSerializer
    else
      render json: @form_user.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_user
      @form_user = ::FormUser.find_or_create_by(id: params[:id], 
                                                account_id: current_user.account.id, 
                                                user_id: params[:user_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def form_user_params
      params.require(:form_user).permit(:form_id)
    end
end
