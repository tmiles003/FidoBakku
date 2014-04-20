class Api::UsersController < Api::ApiController
  
  #authorize_resource
  
  before_action :set_account_user, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  
  # GET /api/users.json
  def index
    render json: current_user.account.users.includes(:form, :team).in_role(params[:role]),
      each_serializer: ::Admin::UserSerializer
  end
  
  # GET /api/users/roles.json
  def roles
    render json: ::User::ROLES, :each_serializer => ::Admin::RoleSerializer
  end
  
  def show
    render json: @account_user, serializer: ::User::UserSerializer
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_user
      @account_user = ::User.in_account(current_user.account.id).find(params[:id]) # in account!
    end
    
    def invalid_user
      logger.error 'No user with this id'
      head :no_content
    end

end
