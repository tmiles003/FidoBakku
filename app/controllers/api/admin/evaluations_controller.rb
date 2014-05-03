class Api::Admin::EvaluationsController < Api::Admin::ApiController
  
  authorize_resource :evaluation_loop, :parent => false
  
  prepend_before_filter :set_evaluation_loop, only: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation_loop
  
  before_action :set_evaluation, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation
  
  # GET /api/admin/evaluations.json
  def index
    render json: @evaluation_loop.evaluations.includes(:user), 
      each_serializer: ::Admin::EvaluationLoop::EvaluationSerializer
  end
  
  # GET /api/admin/evaluations/1.json
  def show
    render json: @evaluation, 
      serializer: ::Admin::Evaluation::EvaluationSerializer
  end

  # POST /api/admin/evaluations.json
  def create
    @evaluation = ::Evaluation.new(evaluation_params) # :: forces root namespace
    @evaluation.evaluation_loop = @evaluation_loop
    @evaluation.account = current_user.account

    if @evaluation.save
      render json: @evaluation, status: :created, 
        serializer: ::Admin::EvaluationLoop::EvaluationSerializer
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/evaluations/1.json
  def update
    if @evaluation.update(evaluation_params)
      render json: @evaluation, serializer: ::Admin::EvaluationLoop::EvaluationSerializer
    else
      render json: @evaluation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/evaluations/1.json
  def destroy
    @evaluation.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation_loop
      @evaluation_loop = ::EvaluationLoop.in_account(current_user.account.id).find(params[:loop_id])
    end
    
    def invalid_evaluation_loop
      logger.error "No evaluation loop with this id: #{params[:loop_id]}"
      error = Hash['error', [t('admin.evaluation_loops.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_evaluation
      @evaluation = ::Evaluation.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_evaluation
      logger.error "No evaluation with this id: #{params[:id]}"
      error = Hash['error', [t('admin.evaluations.record_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:user_id, :mode)
    end
end
