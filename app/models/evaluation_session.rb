class EvaluationSession < ActiveRecord::Base
  
  include InAccount
  
  belongs_to :account
  
  has_many :evaluations, dependent: :destroy
  
  #before_validation :check_plan_evaluation_sessions, on: :create
  
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
