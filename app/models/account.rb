class Account < ActiveRecord::Base
  
  PLANS = %w[basic premium]
  
  validate :email_valid, on: :create
  after_validation :initial_setup, on: :create
  
  validates :name, length: {
    in: 1..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }, on: :update
  
  validates :owner_id, presence: true, on: :update
  
  has_many :evaluation_sessions, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :teams, dependent: :destroy
  
  has_many :account_users, primary_key: :id, foreign_key: :account_id, dependent: :destroy
  has_many :users, through: :account_users
  
  protected
  
  def email_valid # unique, and not in users or accounts
    if email.blank? || !email =~ /.+@.+\..+/i
      errors.add(:email, 'address is invalid')
    else
      unless User.find_by(email: email).nil?
        errors.add(:email, 'address already in use')
      end
    end
  end
  
  def initial_setup
    self.name = 'New Account'
    self.plan = AppConfig.fidobakku['account_plan']
    self.expires_at = AppConfig.fidobakku['account_expiry']
  end
  
end
