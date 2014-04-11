class Api::FeedbackController < Api::ApiController
  
  #load_and_authorize_resource
  
  before_action :set_evaluation, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  # GET /api/evaluation/1.json
  def show
    render json: @evaluation
  end

  # GET /api/evaluation/form
  def form
    render json: @user_evaluation_form
  end
  
  # GET /api/evaluation/scores
  def scores
    render json: Hash.new
  end
  
  # PATCH/PUT /api/user_evaluation/1.json
  def update
    if @evaluation.update(evaluation_params)
      render json: @evaluation
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
    
    def set_user_evaluation_form
      # for this user id? / evaluator_id
      @user_evaluation_form = ::Form.in_account(@account.id).find(params[:form_id])
    end
    
    def invalid_user_evaluation_form
      logger.warn 'no form with this id'
      head :no_content
    end
    
    def evaluation_params
      #params.require(:evaluation).permit(:rating, :complete)
    end
end
