class Form < ActiveRecord::Base
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
end
