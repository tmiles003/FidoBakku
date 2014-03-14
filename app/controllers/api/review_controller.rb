class Api::ReviewController < Api::ApiController
  
  def show
    cols = 'user_reviews.*, 
            reviews.title AS review_title,
            users.name AS user_name, 
            forms.name AS form_name, 
            reviewers_user_reviews.name AS reviewer_name'
    
    @user_review = ::UserReview.select(cols)
      .where(user_id: params[:user_id], reviewer_id: [@user.id])
      .joins(:review, :user, :form, :reviewer)
      .take
    
    # rescue...
    logger.info @user_reviews.to_yaml
  end
  
end
