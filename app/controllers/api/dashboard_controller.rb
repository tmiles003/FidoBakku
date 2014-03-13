class Api::DashboardController < Api::ApiController
  
  def reviews
    @reviews = ::UserReview.where(reviewer_id: @user.id)
  end
  
end
