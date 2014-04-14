class Api::GoalsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_goal, only: [:update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_goal
  
  # GET /api/goals.json
  def index
    render json: ::Goal.for_user(@user, params[:user_id]).with_limit(params[:limit])
  end
  
  # GET /api/goals/1.json
  def show
    render json: @goal, serializer: ::Goal::GoalSerializer
  end
  
  # POST /api/goals.json
  def create
    @goal = ::Goal.new(goal_params) # :: forces root namespace

    if @goal.save
      render json: @goal, status: :created, serializer: ::User::GoalSerializer
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/goals/1.json
  def update
    if @goal.update(goal_params)
      render json: @goal, serializer: ::Goal::GoalSerializer
    else
      render json: @goal.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/goals/1.json
  def destroy
    @goal.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = ::Goal.find(params[:id]) # for this user/in account
    end
    
    def invalid_goal
      logger.warn 'no goal with this id'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:user_id, :title, :content, :private, :done)
    end
end
