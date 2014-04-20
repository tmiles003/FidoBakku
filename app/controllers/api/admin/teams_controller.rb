class Api::Admin::TeamsController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_team, only: [:update, :destroy]

  # GET /api/admin/teams.json
  def index
    render json: current_user.account.teams, each_serializer: ::Admin::TeamSerializer
  end

  # POST /api/admin/teams.json
  def create
    @team = ::Team.new(team_params)
    @team.account = current_user.account

    if @team.save
      render json: @team, status: :created, serializer: ::Admin::TeamSerializer
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/teams/1.json
  def update
    if @team.update(team_params)
      render json: @team, serializer: ::Admin::TeamSerializer
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/teams/1.json
  def destroy
    @team.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = ::Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
