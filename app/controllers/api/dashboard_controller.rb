class Api::DashboardController < Api::ApiController
  
  # GET /api/dashboard/reviews
  def reviews
    @reviews = ::UserReview.where(reviewer_id: @user.id)
  end
  
  # GET /api/dashboard/feedbacks
  def feedbacks
    @feedbacks = ::UserReview.select(:user_id).distinct
  end
  
end
