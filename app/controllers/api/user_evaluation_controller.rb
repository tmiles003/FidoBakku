class Api::UserEvaluationController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_user_evaluation, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation
  
  # GET /api/user_evaluation/1
  # GET /api/user_evaluation/1.json
  def show
    render json: @user_evaluation, serializer: UserEvaluationSerializer
  end
  
  # PATCH/PUT /api/user_evaluation/1
  # PATCH/PUT /api/user_evaluation/1.json
  def update
    if @user_evaluation.update(user_evaluation_params)
      render json: @user_evaluation
    else
      render json: @user_evaluation.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_evaluation
      # for this user id? / evaluator_id
      @user_evaluation = ::UserEvaluation.find(params[:id])
    end
    
    def invalid_user_evaluation
      logger.warn 'no user evaluation with this id'
      head :no_content
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_evaluation_params
      params.require(:user_evaluation).permit(:scores)
    end
end
