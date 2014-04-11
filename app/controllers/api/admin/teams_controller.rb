class Api::Admin::TeamsController < Api::ApiController
  
  before_action :set_team, only: [:update, :destroy]

  # GET /api/teams
  # GET /api/teams.json
  def index
    render json: @account.teams
  end

  # POST /api/teams
  # POST /api/teams.json
  def create
    @team = ::Team.new(team_params)
    @team.account = @account

    if @team.save
      render json: @team, status: :created
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/teams/1
  # PATCH/PUT /api/teams/1.json
  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/teams/1
  # DELETE /api/teams/1.json
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
