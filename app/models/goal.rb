class Goal < ActiveRecord::Base
  
  belongs_to :user
  
  def to_param
    [id, self.slug].join('/')
  end
  
  def slug
    self.content.slice(0..39).downcase.gsub(/[^a-z0-9]/, '-').squeeze('-').slice(0..19)
  end
  
end
