class Evaluation < ActiveRecord::Base
  
  include Upgradable
  
  STATUS = %w[setup open feedback closed archived]
	
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  has_many :user_evaluations, foreign_key: :evaluation_id
  
  before_validation :check_plan_evaluations, on: :create
  
  validates :title, length: {
    in: 4..250,
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
