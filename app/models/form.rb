class Form < ActiveRecord::Base
  
  include Upgradable
  
  has_many :sections, dependent: :destroy
  
  scope :in_account, ->(account_id) { where('account_id = ?', account_id) }
  
  belongs_to :account 
  
  has_many :form_users, dependent: :destroy
  
  before_validation :check_plan_forms, on: :create
  
  # don't delete form if associated with user evaluation
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
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
