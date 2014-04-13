class Api::UsersController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_account_user, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  
  def show
    render json: @account_user, serializer: ::User::UserSerializer
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_user
      @account_user = ::User.find(params[:id]) # in account!
    end
    
    def invalid_user
      logger.warn 'no user with this id'
      head :no_content
    end

end
