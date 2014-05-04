class Api::GoalsController < Api::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_goal, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_goal
  
  # GET /api/goals/1.json
  def show
    render json: @goal, serializer: ::Goal::GoalSerializer
  end
  
  # POST /api/goals.json
  def create
    @goal = ::Goal.new(goal_params) # :: forces root namespace
    @goal.account = current_user.account

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
      @goal = ::Goal.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_goal
      logger.error "No goal with this id: #{params[:id]}"
      error = Hash['error', [t('admin.goals.record_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:user_id, :title, :content, :due_date, :done)
    end
end
