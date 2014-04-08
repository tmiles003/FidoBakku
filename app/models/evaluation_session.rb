class EvaluationSession < ActiveRecord::Base
  
  include Upgradable
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  belongs_to :account
  
  has_many :evaluations, foreign_key: :session_id
  
  before_validation :check_plan_evaluation_sessions, on: :create
  
  validates :title, length: {
    in: 2..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
