class Api::UsersController < Api::ApiController
  
  load_and_authorize_resource
  before_action :set_account_user, only: [:edit, :update, :destroy]
  
  # GET /api/users
  # GET /api/users.json
  def index
    render json: @account.users
  end
  
  # GET /api/users/roles
  def roles
    render json: ::User::ROLES, :each_serializer => RoleSerializer
  end
  
  # used in user_reviews, account
  # GET /api/users/list
  # GET /api/users/list.json
  def list
    @users = @account.account_users.in_role(params[:role])
    #render json: @users # @account.account_users.in_role(params[:role])
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @new_user = ::User.new(user_params) # :: forces root namespace
    @new_user._account = @account
    
    respond_to do |format|
      if @new_user.save
        @user.account.users << @new_user # 
        
        @team_user = ::TeamUser.new(user_id: @new_user.id, team_id: params[:team_id])
        @team_user.save
        
        format.json { render json: @new_user, status: :created }
      else
        format.json { render json: @new_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/users/1
  # PATCH/PUT /api/users/1.json
  def update
    logger.info @account_user.to_yaml
    respond_to do |format|
      if @account_user.update(user_params)
        
        @team_user = ::TeamUser.find_or_create_by(user_id: @account_user.id)
        @team_user.update(team_id: params[:team_id])
        
        format.json { render json: @account_user }
      else
        format.json { render json: @account_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/users/1
  # DELETE /api/users/1.json
  def destroy
    @account_user.destroy # unless @user.id != @current_user.id
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_user
      @account_user = ::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :role, :team_id)
    end
end
