class Api::GoalsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_goal, only: [:update, :user, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_goal
  
  # GET /api/goals
  # GET /api/goals.json
  def index
    render json: ::Goal.for_user(@user, params[:user_id]).with_limit(params[:limit])
  end
  
  # GET /api/goals/1
  # GET /api/goals/1.json
  def show
    render json: @goal
  end
  
  # GET /api/goals/team
  # GET /api/goals/team.json
  def team
    render json: []
  end
  
  # POST /api/goals
  # POST /api/goals.json
  def create
    @goal = ::Goal.new(goal_params) # :: forces root namespace
    # @goal.user = @user

    respond_to do |format|
      if @goal.save
        format.json { render json: @goal, status: :created }
      else
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/goals/1
  # PATCH/PUT /api/goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.json { render json: @goal, status: :created }
      else
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /api/goals/1
  # DELETE /api/goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = ::Goal.find(params[:id])
    end
    
    def invalid_goal
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:user_id, :title, :content, :due_date, :is_private, :is_complete)
    end
end