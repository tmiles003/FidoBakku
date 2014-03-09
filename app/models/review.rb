class Review < ActiveRecord::Base
	
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
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
