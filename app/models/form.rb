class Form < ActiveRecord::Base
  
  include InAccount
  
  has_many :form_sections, dependent: :destroy
  
  belongs_to :account
  
  # don't delete form if associated with evaluation
  #belongs_to :evaluation
  
  has_many :form_users, dependent: :destroy
  
  has_many :form_parts, foreign_key: :part_id
  has_many :children, through: :form_parts, source: :children
  
  validates :name, length: {
    in: 1..100
  }
  
  # dynamic ordering when generating form
  attr_accessor :ordr
  
  scope :parts, -> { 
    where(shared: true).where.not(id: self.id)
  }
  
  # enables picking only shared forms
  scope :shared, lambda { |shared|
    where('shared' => shared) unless shared.nil?
  }
  
  # excludes the current form, if editing a shared one
  scope :exclude, lambda { |exclude|
    where.not('id' => exclude) unless exclude.nil?
  }

  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-').squeeze('-')
  end
  
end
