class EvaluationSession < ActiveRecord::Base
  
  include InAccount
  
  belongs_to :account
  
  has_many :evaluations, dependent: :destroy
  
  before_create :initial_setup
  
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
  
  protected
  
  def initial_setup
    self.progress = ActiveSupport::JSON.encode Hash.new
  end
  
end
