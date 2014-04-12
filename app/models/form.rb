class Form < ActiveRecord::Base
  
  has_many :form_sections, dependent: :destroy
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  belongs_to :account
  
  # don't delete form if associated with evaluation
  #belongs_to :evaluation
  
  has_many :form_users, dependent: :destroy
  has_many :form_parts, dependent: :destroy
  
  validates :name, length: {
    in: 2..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  # dynamic ordering when generating form
  attr_accessor :ordr
  
  scope :sharable, lambda { |shared|
    where('shared' => shared) unless shared.nil?
  }

  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
