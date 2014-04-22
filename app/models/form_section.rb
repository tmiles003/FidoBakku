class FormSection < ActiveRecord::Base
  
  include Upgradable
  
  belongs_to :form
  
  has_many :form_comps, dependent: :destroy
  
  scope :in_account, ->(account_id) { 
    joins(:form)
    .where('account_id = ?', account_id)
    .readonly(false) # required, otherwise record is "ReadOnly"
  }
  
  validates :name, length: {
    in: 1..100
  }
  
  def next_ordr
    section = ::FormSection.where(form_id: self.form_id).order(ordr: :desc).take
    self.ordr = section.nil? ? 10 : section.ordr + 10
  end
  
end
