module Upgradable
  extend ActiveSupport::Concern
  
  #helper contains Exceptions, which are caught in api/api_controller
  include UpgradeHelper
  
  included do
    attr_accessor :_account
  end

  def check_plan
    #logger.info '>> checking plan limit'
        
    if ::Account::PLANS.include? self.account.plan
      @plan = self.account.plan 
    else
      @plan = 'basic'
    end
    
    if !AppConfig.fidobakku['account_limits'][@plan]['can_add_content']
      raise NeedUpgrade.new
    end
    
  end
  
end
