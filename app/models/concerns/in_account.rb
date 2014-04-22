module InAccount
  extend ActiveSupport::Concern
  
  included do
    scope :in_account, ->(account_id) { 
      where('account_id = ?', account_id)
    }
  end
  
end
