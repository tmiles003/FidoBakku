class Api::Admin::UsersController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_account_user, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  
  # GET /api/admin/users.json
  def index
    users = current_user.account.users
      .includes(:form, :team)
      .in_role(params[:role])
      .has_form(params[:has_form])
      
    render json: users, each_serializer: ::Admin::UserSerializer
  end
  
  # GET /api/admin/users/roles.json
  def roles
    render json: ::User::ROLES, :each_serializer => ::Admin::RoleSerializer
  end
  
  # POST /api/admin/users.json
  def create
    @new_user = ::User.new(user_params) # :: forces root namespace
    
    if @new_user.save
      current_user.account.users << @new_user
      
      @team_user = ::TeamUser.find_or_create_by(user_id: @new_user.id, account_id: current_user.account.id, team_id: params[:team_id])
      @form_user = ::FormUser.find_or_create_by(user_id: @new_user.id, account_id: current_user.account.id)
      
      render json: @new_user, status: :created, serializer: ::Admin::UserSerializer
    else
      render json: @new_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/users/1.json
  def update
    if @account_user.update(user_params)
      
      @team_user = ::TeamUser.find_or_create_by(user_id: @account_user.id, account_id: current_user.account.id)
      @team_user.update(team_id: params[:team_id])
      
      render json: @account_user, serializer: ::Admin::UserSerializer
    else
      render json: @account_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/users/1.json
  def destroy
    if @account_user.id != current_user.id
      @account_user.destroy
      head :no_content
    else
      error = Hash['error', [t('admin.users.self_delete')]]
      render json: error, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_user
      @account_user = ::User.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_user
      logger.error "No user with this id: #{params[:id]}"
      error = Hash['error', [t('admin.users.record_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :role, :team_id)
    end
end
