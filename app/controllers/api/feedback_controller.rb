class Api::FeedbackController < Api::ApiController
  
  authorize_resource :evaluation, :parent => false
  
  prepend_before_filter :set_evaluation, only: [:show, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  # GET /api/feedback/1.json
  def show
    render json: @evaluation, serializer: ::Feedback::EvaluationSerializer
  end

  # PATCH/PUT /api/feedback/1.json
  def update
    if @evaluation.update(evaluation_params)
      render nothing: true, status: :ok
      #render json: @evaluation
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = ::Evaluation.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_evaluation
      logger.error "No evaluation with this id: #{params[:id]}"
      error = Hash['error', [t('admin.evaluations.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def evaluation_params
      params.require(:feedback).permit(:rating, :done)
    end
end
