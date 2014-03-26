class Api::CommentsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_comment, only: [:index, :update, :destroy]

  # GET /api/comments
  # GET /api/comments.json
  def index
  end

  # PATCH/PUT /api/comments/1
  # PATCH/PUT /api/comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.json { head :no_content }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/comments/1
  # DELETE /api/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = ::Comment.find_or_create_by(review_id: params[:review_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
        .merge(review_id: params.require(:review_id))
    end
end
