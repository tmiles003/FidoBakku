class Api::UserReviewsController < Api::ApiController
  
  before_action :set_user_review, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user_review
  
  # GET /api/user_reviews/1
  # GET /api/user_reviews/1.json
  def show
    #
  end

  # POST /api/user_reviews
  # POST /api/user_reviews.json
  def create
    @user_review = ::UserReview.new(user_review_params)

    respond_to do |format|
      if @user_review.save
        format.json { render json: @user_review, status: :created }
      else
        format.json { render json: @user_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/user_reviews/1
  # PATCH/PUT /api/user_reviews/1.json
  def update
    respond_to do |format|
      if @user_review.update(user_review_params)
        format.json { head :no_content }
      else
        format.json { render json: @user_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/user_reviews/1
  # DELETE /api/user_reviews/1.json
  def destroy
    @user_review.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_review
      # for this user id?
      @user_review = ::UserReview.find(params[:id])
    end
    
    def invalid_user_review
      logger.warn 'User review is not valid'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_review_params
    	# array of user reviewer_ids ?
      params.require(:user_review).permit(:user_id, :form_id, :reviewer_id, :scores)
      	.merge(review_id: params.require(:review_id))
    end
end
