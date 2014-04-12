class Api::Admin::FormUsersController < Api::ApiController
  
  #load_and_authorize_resource
  
  before_action :set_form
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  before_action :set_form_user, only: [:assign]
  
  # GET /api/admin/forms/1/users.json
  def users
    users = @account.users
      .joins('LEFT JOIN form_users ON form_users.user_id = users.id')
      .where('form_users.user_id IS NULL OR form_users.form_id = ?', @form.id)
      .includes(:form, :team)
    
    render json: users, each_serializer: ::Admin::UserSerializer
  end

  # PATCH/PUT /api/admin/forms/1/assign/1.json
  def assign
    if @form_user.new_record? # assign user to form
      @form_user.form = @form
      @form_user.save
    else # clear assignment
      @form_user.destroy
    end
    
    render json: @form_user.user, serializer: ::Admin::UserSerializer
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.in_account(@account.id).find(params[:id])
    end
    
    def invalid_form
      logger.info 'no form with this id'
      head :no_content
    end
    
    def set_form_user
      @form_user = ::FormUser.find_or_initialize_by(user_id: params[:user_id])
    end
    
end