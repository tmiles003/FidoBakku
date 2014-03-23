class Account < ActiveRecord::Base
  
  TYPES = %w[basic value social premium]
  
  validate :email_valid, on: :create
  after_validation :initial_setup, on: :create
  
  validates :name, length: {
    in: 2..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }, on: :update
  
  validates :owner_id, presence: true, on: :update
  
  has_many :account_users
  has_many :users, through: :account_users
  
  has_many :forms
  
  has_many :reviews
  
  protected
  
  def email_valid # unique, and not in users or accounts
    if email.blank? || !email =~ /.+@.+\..+/i
      errors.add(:email, 'address is invalid')
    else
      unless User.find_by(email: email).nil?
        errors.add(:email, 'address already in use')
      end
    end
        
    #errors.add(:email, 'is being deliberately being failed for now')
  end
  
  def initial_setup
    self.name = 'New Account'
    self.plan = AppConfig.fidobakku['account_type']
    self.expires_at = AppConfig.fidobakku['account_expiry']
  end
  
end
