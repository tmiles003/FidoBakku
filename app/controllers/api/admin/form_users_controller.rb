class Api::Admin::FormUsersController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_form, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  
  before_action :set_form_user, only: [:update]
  
  # GET /api/admin/forms/1.json
  def index
    form_users = ::FormUser
      .where('form_users.form_id IS NULL OR form_users.form_id = ?', @form.id)
      .includes(:form, user: :team)
    
    render json: form_users, each_serializer: ::Admin::Form::FormUserSerializer
  end

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
    def set_form
      @form = ::Form.in_account(current_user.account.id).find(params[:form_id])
    end
    
    def invalid_form
      logger.error 'No form with this id'
      head :no_content
    end
    
    def set_form_user
      @form_user = ::FormUser.find_or_create_by(user_id: params[:user_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def form_user_params
      params.require(:form_user).permit(:form_id)
    end
end
