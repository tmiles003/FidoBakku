class User < ActiveRecord::Base
  
  include UsersHelper
  
  ROLES = %w[employee manager admin]
  
  before_validation :initial_setup, on: :create
  
  validates :name, length: {
    in: 1..100
  }
  
  validates :role, inclusion: { 
    in: ROLES
  }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  has_one :account_user #, dependent: :destroy
  has_one :account, through: :account_user
  
  has_one :team_user, dependent: :destroy
  has_one :team, through: :team_user
  
  has_many :goals, dependent: :destroy
  
  has_one :form_user, primary_key: :id, foreign_key: :user_id, dependent: :destroy
  has_one :form, through: :form_user
  has_many :form_users
  
  has_many :evaluations, dependent: :destroy
  #has_many :user_evaluations, dependent: :destroy # (as reviewer - remove id, update name)
  
  has_many :comments # don't delete comments left on others' stuff
  
  scope :in_account, ->(account_id) { 
    joins(:account)
    .where('account_id = ?', account_id)
    .readonly(false)
  }
  
  scope :in_role, lambda { |role|
    where('role' => role) unless role.nil?
  }
  
  scope :has_form, lambda { |has_form|
    joins(:form_users).where('form_id IS NOT NULL') unless has_form.nil?
  }

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
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
