class Api::FeedbacksController < Api::ApiController
  
  before_action :set_feedback, only: [:index, :update, :destroy]

  # GET /api/feedbacks
  # GET /api/feedbacks.json
  def index
  end

  # PATCH/PUT /api/feedbacks/1
  # PATCH/PUT /api/feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.json { head :no_content }
      else
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/feedbacks/1
  # DELETE /api/feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = ::Feedback.find_or_create_by(review_id: params[:review_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:content)
        .merge(review_id: params.require(:review_id))
    end
end
