class Evaluation < ActiveRecord::Base
  
  belongs_to :evaluation_session
  has_one :user
  has_many :user_evaluations
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    ::User.find(self.user_id).slug
  end
  
end
