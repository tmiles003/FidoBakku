class Form < ActiveRecord::Base
  
  has_many :topics, dependent: :destroy
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  # don't delete form if associated with user review
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  # pretty urls, no other use
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
