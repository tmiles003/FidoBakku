class Goal < ActiveRecord::Base
  
  include InAccount
  include Upgradable
  
  belongs_to :user
  has_many :comments, primary_key: :id, foreign_key: :goal_id, dependent: :destroy
  
  belongs_to :account
  
  before_validation :check_plan, on: :create
  
  validates :title, length: {
    in: 1..100
  }
  
  scope :for_user, lambda { |user, param|
    user_id = param.nil? ? user.id : param.to_i
    where(user_id: user_id)
  }
  
  scope :with_limit, lambda { |limit|
    limit(limit) unless limit.nil?
  }
  
  def to_param
    [id, self.slug].join('/')
  end
  
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
