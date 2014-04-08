class Api::EvaluationSessionsController < Api::ApiController
  
  load_and_authorize_resource
  
  # GET /api/evaluation_sessions
  # GET /api/evaluation_sessions.json
  def index
    render json: @account.evaluation_sessions
  end

  # GET /api/evaluation_sessions/1
  # GET /api/evaluation_sessions/1.json
  def show
    render json: @evaluation_session
  end

  # POST /api/evaluation_sessions
  # POST /api/evaluation_sessions.json
  def create
    @evaluation_session = ::EvaluationSession.new(evaluation_session_params)
    @evaluation_session.account = @account
    @evaluation_session._account = @account

    respond_to do |format|
      if @evaluation_session.save
        format.json { render json: @evaluation_session, status: :created }
      else
        format.json { render json: @evaluation_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/evaluation_sessions/1
  # PATCH/PUT /api/evaluation_sessions/1.json
  def update
    respond_to do |format|
      if @evaluation_session.update(evaluation_session_params)
        format.json { render json: @evaluation_session }
      else
        format.json { render json: @evaluation_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/evaluation_sessions/1
  # DELETE /api/evaluation_sessions/1.json
  def destroy
    @evaluation_session.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_session_params
      params.require(:evaluation_session).permit(:title)
    end
end
