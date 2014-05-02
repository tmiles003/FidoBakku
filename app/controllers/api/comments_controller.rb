class Api::CommentsController < Api::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_comment, only: [:update, :destroy]
  
  # POST /api/comments
  def create
    @comment = ::Comment.new(comment_params) # :: forces root namespace
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: :created, serializer: ::Goal::CommentSerializer
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /api/comments/1.json
  def update
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
      params.require(:comment).permit(:goal_id, :content)
    end
end
