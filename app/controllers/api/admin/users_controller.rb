class Api::Admin::UsersController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_account_user, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  
  # GET /api/admin/users.json
  def index
    render json: @account.users.includes(:form, :team).in_role(params[:role]),
      each_serializer: ::Admin::UserSerializer
  end
  
  # GET /api/users/current
  # GET /api/users/current.json
  def current
    render json: @user
  end
  
  # GET /api/admin/users/1.json
  def show
    render json: @account_user
  end
  
  # GET /api/admin/users/roles.json
  def roles
    render json: ::User::ROLES, :each_serializer => ::Admin::RoleSerializer
  end
  
  # POST /api/admin/users.json
  def create
    @new_user = ::User.new(user_params) # :: forces root namespace
    
    if @new_user.save
      @user.account.users << @new_user
      
      @team_user = ::TeamUser.find_or_initialize_by(user_id: @new_user.id, team_id: params[:team_id])
      @team_user.save
      
      render json: @new_user, status: :created, serializer: ::Admin::UserSerializer
    else
      render json: @new_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/users/1.json
  def update
    if @account_user.update(user_params)
      
      @team_user = ::TeamUser.find_or_create_by(user_id: @account_user.id)
      @team_user.update(team_id: params[:team_id])
      
      render json: @account_user, serializer: ::Admin::UserSerializer
    else
      render json: @account_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/users/1.json
  def destroy
    @account_user.destroy # unless @user.id != @current_user.id
    head :no_content
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :role, :team_id)
    end
end