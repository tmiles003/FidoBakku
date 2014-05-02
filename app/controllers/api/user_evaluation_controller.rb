class Api::UserEvaluationController < Api::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_user_evaluation, only: [:show, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation
  
  # GET /api/user_evaluation/1.json
  def show
    render json: @user_evaluation, serializer: ::Evaluation::UserEvaluationSerializer
  end
  
  # PATCH/PUT /api/user_evaluation/1.json
  def update
    if @user_evaluation.update(user_evaluation_params)
      render json: @user_evaluation, serializer: ::Evaluation::ProgressSerializer
    else
      render json: @user_evaluation.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_evaluation
      # for this user id? / evaluator_id
      @user_evaluation = ::UserEvaluation.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_user_evaluation
      logger.error "No user evaluation with this id: #{params[:id]}"
      error = Hash['error', [t('admin.user_evaluations.record_not_found')]]
      render json: error, status: :not_found
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_evaluation_params
      params.require(:user_evaluation).permit(:ratings)
    end
end
