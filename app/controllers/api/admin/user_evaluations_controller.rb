class Api::Admin::UserEvaluationsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_evaluation, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  before_action :set_user_evaluation, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation
  
  # GET /api/user_evals
  # GET /api/user_evals.json
  def index
    render json: @evaluation.user_evaluations, each_serializer: UserEvaluationsSerializer
  end
  
  # GET /api/user_evals/1
  # GET /api/user_evals/1.json
  def show
    render json: @user_evaluation, serializer: UserEvaluationsSerializer
  end
  
  # POST /api/user_evals
  # POST /api/user_evals.json
  def create
    @user_evaluation = ::UserEvaluation.new(user_evaluation_params)
    #logger.info user_evaluation_params.to_yaml

    if @user_evaluation.save
      render json: @user_evaluation, status: :created, serializer: UserEvaluationsSerializer
    else
      render json: @user_evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/user_evals/1
  # DELETE /api/user_evals/1.json
  def destroy
    @user_evaluation.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = ::Evaluation.find(params[:evaluation_id])
    end
    
    def invalid_evaluation
      logger.warn 'no evaluation with this id'
      head :no_content
    end
    
    def set_user_evaluation
      # for this user id?
      @user_evaluation = ::UserEvaluation.find(params[:id])
    end
    
    def invalid_user_evaluation
      logger.warn 'no user evaluation with this id'
      head :no_content
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_evaluation_params
      params.require(:user_evaluation).permit(:user_id, :form_id, :evaluation_id, :evaluator_id)
    end
end
