class Api::ApiController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_account
  
  private
    # Use callbacks to share common setup or constraints between actions.

    def set_user
      @user = current_user
    end
    
    def set_account
      @account = current_user.account
    end
    
end
