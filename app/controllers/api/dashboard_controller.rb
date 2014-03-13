class Api::DashboardController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_user
  
  def reviews
    @reviews = ::UserReview.where(reviewer_id: @user.id)
  end
  
  private
  
    def set_user
      @user = current_user
    end
    
end
