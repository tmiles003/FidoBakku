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
  
  def check_plan_topics
    num_topics = Account.joins(forms: :topics).where(id: _account.id).count
    check_plan_limit 'topics', num_topics
  end
  
  def check_plan_benchmarks
    num_benchmarks = Account.joins(forms: [{topics: :benchmarks}]).where(id: _account.id).count
    check_plan_limit 'benchmarks', num_benchmarks
  end
  
  def check_plan_reviews
    check_plan_limit 'reviews', _account.reviews.count
  end
  
end
