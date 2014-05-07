class Api::DashboardController < Api::ApiController
  
  def index
    render json: current_user, serializer: DashboardSerializer
  end
  
end
