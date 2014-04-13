class Api::Admin::EvaluationSessionsController < Api::ApiController
  
  load_and_authorize_resource
  
  # GET /api/admin/evaluation_sessions.json
  def index
    render json: @account.evaluation_sessions, each_serializer: ::Admin::EvaluationSessionSerializer
  end

  # GET /api/admin/evaluation_sessions/1.json
  def show
    render json: @evaluation_session, serializer: ::Admin::EvaluationSessionSerializer
  end

  # POST /api/admin/evaluation_sessions.json
  def create
    @evaluation_session = ::EvaluationSession.new(evaluation_session_params)
    @evaluation_session.account = @account

    if @evaluation_session.save
      render json: @evaluation_session, status: :created, serializer: ::Admin::EvaluationSessionSerializer
    else
      render json: @evaluation_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/evaluation_sessions/1.json
  def update
    if @evaluation_session.update(evaluation_session_params)
      render json: @evaluation_session, serializer: ::Admin::EvaluationSessionSerializer
    else
      render json: @evaluation_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/evaluation_sessions/1.json
  def destroy
    @evaluation_session.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_session_params
      params.require(:evaluation_session).permit(:title)
    end
end
