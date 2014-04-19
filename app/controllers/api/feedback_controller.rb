class Api::FeedbackController < Api::ApiController
  
  authorize_resource :evaluation, :parent => false
  
  prepend_before_filter :set_evaluation, only: [:show]
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
      @evaluation = ::Evaluation.find(params[:id])
    end
    
    def invalid_evaluation
      logger.warn 'no evaluation with this id'
      head :no_content
    end
    
    def evaluation_params
      params.require(:evaluation).permit(:rating, :done)
    end
end
