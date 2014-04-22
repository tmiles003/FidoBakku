class Account < ActiveRecord::Base
  
  PLANS = %w[basic premium]
  
  validate :email_valid, :email_unique, on: :create
  after_validation :initial_setup, on: :create
  
  validates :name, length: {
    in: 1..100,
  }, on: :update
  validates :owner_id, presence: true, on: :update
  
  has_many :evaluation_sessions, dependent: :destroy
  has_many :forms, dependent: :destroy
  has_many :teams, dependent: :destroy
  
  has_many :account_users, primary_key: :id, foreign_key: :account_id, dependent: :destroy
  has_many :users, through: :account_users
  
  protected
  
  def email_valid # unique, and not in users table
    #logger.info /.+@.+\..+/i.match(email).nil?
    if /.+@.+\..+/i.match(email).nil?
      errors.add(:email, 'address is invalid')
    end
  end
  
  def email_unique
    unless User.find_by(email: email).nil?
      errors.add(:email, 'address is invalid')
    end
  end
  
  def initial_setup
    self.name = 'New Account'
    self.plan = AppConfig.fidobakku['initial_plan']
    self.expires_at = Date.today.advance(:days => AppConfig.fidobakku['demo_days'])
  end
  
end
