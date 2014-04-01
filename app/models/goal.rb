class Goal < ActiveRecord::Base
  
  belongs_to :user
  
  validates :title, length: {
    in: 2..100,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  scope :for_user, lambda { |user, param|
    user_id = param.nil? ? user.id : param.to_i
    where(user_id: user_id)
  }
  
  def to_param
    [id, self.slug].join('/')
  end
  
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
