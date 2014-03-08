class Form < ActiveRecord::Base
  
  has_many :form_sections, dependent: :destroy
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
