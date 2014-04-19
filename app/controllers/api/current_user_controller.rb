class Api::CurrentUserController < Api::ApiController
  
  # GET /api/current_user
  def show
    render json: current_user, serializer: ::CurrentUserSerializer
  end
  
end
