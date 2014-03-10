class Api::ReviewsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_account
  before_action :set_review, only: [:update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_review
  
  # GET /api/reviews
  # GET /api/reviews.json
  def index
    @reviews = @account.reviews
  end

  # POST /api/reviews
  # POST /api/reviews.json
  def create
    @review = ::Review.new(review_params) # :: forces root namespace
    @review.account_id = @account.id

    respond_to do |reviewat|
      if @review.save
        reviewat.json { render json: @review, status: :created }
      else
        reviewat.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/reviews/1
  # PATCH/PUT /api/reviews/1.json
  def update
    respond_to do |reviewat|
      if @review.update(review_params)
        reviewat.json { head :no_content }
      else
        reviewat.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/reviews/1
  # DELETE /api/reviews/1.json
  def destroy
    @review.destroy
    respond_to do |reviewat|
      reviewat.json { head :no_content }
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
    def review_params
      params.require(:review).permit(:title, :open, :archived)
    end
end
