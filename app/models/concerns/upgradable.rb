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
  
  def check_plan_users
    check_plan_limit 'users', _account.account_users.count
  end
  
  def check_plan_forms
    check_plan_limit 'forms', _account.forms.count
  end
  
  def check_plan_sections
    num_sections = Account.joins(forms: :sections).where(id: _account.id).count
    check_plan_limit 'sections', num_sections
  end
  
  def check_plan_comps
    num_comps = Account.joins(forms: [{sections: :comps}]).where(id: _account.id).count
    check_plan_limit 'comps', num_comps
  end
  
  def check_plan_evaluations
    check_plan_limit 'evaluations', _account.evaluations.count
  end
  
end
