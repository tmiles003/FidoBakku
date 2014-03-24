class Review < ActiveRecord::Base
  
  STATUS = %w[setup review feedback closed archived]
	
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  has_many :user_reviews, foreign_key: :review_id
  
  validates :title, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
	# pretty urls, no other use
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
