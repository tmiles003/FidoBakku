class Api::Admin::ApiController < Api::ApiController

  def current_ability
    @current_ability ||= AbilityAdmin.new(current_user)
  end  

end
