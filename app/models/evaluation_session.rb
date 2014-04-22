class EvaluationSession < ActiveRecord::Base
  
  include InAccount
  
  belongs_to :account
  
  has_many :evaluations, dependent: :destroy
  
  validates :title, length: {
    in: 1..100
  }
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
