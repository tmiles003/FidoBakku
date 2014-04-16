class Goal < ActiveRecord::Base
  
  belongs_to :user
  has_many :comments, primary_key: :id, foreign_key: :goal_id
  
  validates :title, length: {
    in: 2..100,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  # validate user_id is you or someone in the admin/manager's team
  
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
