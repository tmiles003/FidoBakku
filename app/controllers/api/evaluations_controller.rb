class Api::EvaluationsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_evaluation_session, only: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation_session
  
  # GET /api/evaluations
  # GET /api/evaluations.json
  def index
    render json: @evaluation_session.evaluations
  end
  
  # GET /api/evaluations/1
  # GET /api/evaluations/1.json
  def show
    render json: @evaluation
  end

  # POST /api/evaluations
  # POST /api/evaluations.json
  def create
    @evaluation = ::Evaluation.new(evaluation_params) # :: forces root namespace
    @evaluation.session_id = @evaluation_session.id

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
    def set_evaluation_session
      @evaluation_session = ::EvaluationSession.in_account(@account.id).find(params[:session_id])
    end
    
    def invalid_evaluation_session
      logger.info 'no evaluation_session with this id'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:user_id)
    end
end
