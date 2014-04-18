class Api::UserEvaluationController < Api::ApiController
  
  #authorize_resource
  
  before_action :set_user_evaluation, only: [:show, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation
  
  before_action :set_user_evaluation_form, only: [:form]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation_form
  
  # GET /api/user_evaluation/1.json
  def show
    render json: @user_evaluation, serializer: ::Evaluation::UserEvaluationSerializer
  end
  
  # GET /api/user_evaluation/form.json
  def form
    logger.warn 'this might not be in use (Api::UserEvaluationController#form)'
    render json: @user_evaluation_form, serializer: UserEvaluationFormSerializer
  end
  
  # PATCH/PUT /api/user_evaluation/1.json
  def update
    if @user_evaluation.update(user_evaluation_params)
      #render nothing: true, status: :ok # no need to send data back, just "ok"
      render json: @user_evaluation.progress
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
    
    def set_user_evaluation_form
      # for this user id? / evaluator_id
      @user_evaluation_form = ::Form.in_account(@account.id).find(params[:form_id])
    end
    
    def invalid_user_evaluation_form
      logger.warn 'no form with this id'
      head :no_content
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_evaluation_params
      params.require(:user_evaluation).permit(:ratings)
    end
end
