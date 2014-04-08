class Evaluation < ActiveRecord::Base
  
  has_one :user
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    #::User.find(self.user_id).slug
  end
  
end
