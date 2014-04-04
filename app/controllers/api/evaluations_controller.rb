class Api::EvaluationsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_evaluation, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  # GET /api/evaluations
  # GET /api/evaluations.json
  def index
    render json: @account.evaluations
  end
  
  # GET /api/evaluations/statuses
  def statuses
    render json: ::Evaluation::STATUS, each_serializer: EvaluationStatusSerializer
  end
  
  # GET /api/evaluations/1
  # GET /api/evaluations/1.json
  def show
    #
  end

  # POST /api/evaluations
  # POST /api/evaluations.json
  def create
    @evaluation = ::Evaluation.new(evaluation_params) # :: forces root namespace
    @evaluation.account_id = @account.id
    @evaluation._account = @account

    respond_to do |format|
      if @evaluation.save
        format.json { render json: @evaluation, status: :created }
      else
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/evaluations/1
  # PATCH/PUT /api/evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.json { head :no_content }
      else
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/evaluations/1
  # DELETE /api/evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = ::Evaluation.in_account(@account.id).find(params[:id])
    end
    
    def invalid_evaluation
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:title, :status)
    end
end
