class Api::Admin::UserEvaluationsController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_evaluation, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  before_action :set_user_evaluation, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_evaluation
  
  # GET /api/admin/user_evaluations.json
#  def index
#    render json: @evaluation.user_evaluations.includes(:evaluator), 
#      each_serializer: ::Admin::Evaluation::UserEvaluationSerializer
#  end
  
  # POST /api/admin/user_evaluations.json
  def create
    @user_evaluation = ::UserEvaluation.new(user_evaluation_params)
    @user_evaluation.evaluation = @evaluation
    @user_evaluation.account = current_user.account
    
    if @user_evaluation.save
      render json: @user_evaluation, status: :created, 
        serializer: ::Admin::Evaluation::UserEvaluationSerializer
    else
      render json: @user_evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/user_evaluations/1.json
  def destroy
    @user_evaluation.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = ::Evaluation.in_account(current_user.account.id).find(params[:evaluation_id])
    end
    
    def invalid_evaluation
      logger.error "No evaluation with this id: #{params[:evaluation_id]}"
      error = Hash['error', [t('admin.evaluations.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_user_evaluation
      @user_evaluation = ::UserEvaluation.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_user_evaluation
      logger.error "No user evaluation with this id: #{params[:id]}"
      error = Hash['error', [t('admin.evaluations.record_not_found')]]
      render json: error, status: :not_found
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_evaluation_params
      params.require(:user_evaluation).permit(:evaluator_id)
    end
end
