class Api::Admin::EvaluationLoopsController < Api::Admin::ApiController
  
  authorize_resource :evaluation_loop, :parent => false
  
  prepend_before_filter :set_evaluation_loop, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_evaluation_loop
  
  # GET /api/admin/evaluation_loops.json
  def index
    render json: current_user.account.evaluation_loops, 
      each_serializer: ::Admin::EvaluationLoopSerializer
  end

  # GET /api/admin/evaluation_loops/1.json
  def show
    render json: @evaluation_loop, 
      serializer: ::Admin::EvaluationLoop::LoopSerializer
  end

  # POST /api/admin/evaluation_loops.json
  def create
    @evaluation_loop = ::EvaluationLoop.new(evaluation_loop_params)
    @evaluation_loop.account = current_user.account

    if @evaluation_loop.save
      render json: @evaluation_loop, status: :created, 
        serializer: ::Admin::EvaluationLoopSerializer
    else
      render json: @evaluation_loop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/evaluation_loops/1.json
  def update
    if @evaluation_loop.update(evaluation_loop_params)
      render json: @evaluation_loop, serializer: ::Admin::EvaluationLoopSerializer
    else
      render json: @evaluation_loop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/evaluation_loops/1.json
  def destroy
    @evaluation_loop.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation_loop
      @evaluation_loop = ::EvaluationLoop.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_evaluation_loop
      logger.error "No evaluation loop with this id: #{params[:id]}"
      error = Hash['error', [t('admin.evaluation_loops.record_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_loop_params
      params.require(:evaluation_loop).permit(:title)
    end
end
