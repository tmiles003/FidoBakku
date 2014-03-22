class Account < ActiveRecord::Base
  
  TYPES = %w[basic value social premium]
  
  validate :email_valid
  after_validation :initial_setup, on: :create
	
	has_many :account_users
	has_many :users, through: :account_users
	
	has_many :forms
	
	has_many :reviews
  
  def email_valid # unique, and not in users or accounts
    if email.blank? || !email =~ /.+@.+\..+/i
      errors.add(:email, 'address is invalid')
    else
      unless Account.find_by(email: email).nil? && User.find_by(email: email).nil?
        errors.add(:email, 'already in use')
      end
    end
        
    #errors.add(:email, 'is being deliberately being failed for now')
  end
  
  def initial_setup
    self.name = 'New Account'
  end
	
end
