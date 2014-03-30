class Api::TeamsController < Api::ApiController
  
  before_action :set_team, only: [:update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = @account.teams
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = ::Team.new(team_params)
    @team.account = @account

    respond_to do |format|
      if @team.save
        format.json { render json: @team, status: :created }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.json { head :no_content }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
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
