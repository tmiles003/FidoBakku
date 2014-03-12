class Api::UserReviewsController < ApplicationController
	
  before_action :authenticate_user!
  before_action :set_account
  #before_action :set_review
  #rescue_from ActiveRecord::RecordNotFound, with: :invalid_review
  
  # GET /api/user_reviews/1
  # GET /api/user_reviews/1.json
  def show
    set_review
    @user_reviews = @review.user_reviews
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
    def set_account
      @account = current_user.account
    end
    
    def set_review
      @review = ::Review.in_account(@account.id).find(params[:id])
    end
    
    def invalid_review
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_review_params
    	# allow array of user reviews?
      params.require(:user_review).permit(:user_id, :form_id, :reviewer_id)
      	.merge(review_id: params.require(:review_id))
    end
end
