class Api::DashboardController < Api::ApiController
  
  def index
    render json: current_user.account, serializer: DashboardSerializer
  end
  
end
