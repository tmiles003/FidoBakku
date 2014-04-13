class Api::CommentsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_comment, only: [:update, :destroy]

  # GET /api/comments.json
  def index
  end
  
  # PATCH/PUT /api/comments/1.json
  def update
    @comment.user = current_user
    if @comment.update(comment_params)
      render json: @comment, serializer: @comment.serializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/comments/1.json
  def destroy
    @comment.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = ::Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
