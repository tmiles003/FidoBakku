module Upgradable
  extend ActiveSupport::Concern
  
  #helper contains Exceptions, which are caught in api/api_controller
  include UpgradeHelper
  
  # allows passing @account in controller
  # maybe refactor to take @account from session[] ??
  included do
    attr_accessor :_account
  end

  def check_plan_limit section, check
    #logger.info '>> checking plan limit'
    
    if ::Account::PLANS.include? _account.plan
      plan = _account.plan 
    else
      plan = 'basic'
    end
    
    if check >= AppConfig.fidobakku['account_limits'][plan][section]
      raise LimitReached.new
    end
    
  end
  
  def check_plan_evaluation_sessions
    check_plan_limit 'evaluation_sessions', _account.evaluation_sessions.count
  end
  
end
