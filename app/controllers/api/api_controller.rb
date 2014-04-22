class Api::ApiController < ApplicationController
  
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied, with: :forbidden_access
  
  rescue_from UpgradeHelper::NeedUpgrade, with: :upgrade_needed
  
  #before_action :set_user
  #before_action :set_account
  
  def default_serializer_options
    { root: false }
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def forbidden_access
      head :forbidden
    end
    
    def upgrade_needed
      render text: 'Upgrade to remove limits', status: :payment_required
    end

    def set_user
      @user = current_user
    end
    
    def set_account
      @account = current_user.account
    end
    
end
