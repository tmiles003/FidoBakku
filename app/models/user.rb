class User < ActiveRecord::Base
  
  include UsersHelper
  include Upgradable
  
  ROLES = %w[employee manager admin]
  
  before_validation :initial_setup, on: :create
  before_validation :check_plan_users, on: :create
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  has_one :account_user, dependent: :destroy
  has_one :account, through: :account_user
  
  has_one :form, through: :form_user
  
  has_many :user_reviews
  
  def initial_setup
    if name.nil?
      self.name = 'New User'
    end
    if role.nil? 
      # safe default; promote after successful account creation, in account controller
      self.role = 'employee'
    end
    self.password = gen_random_password
  end
  
  # pretty urls, no other use
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
