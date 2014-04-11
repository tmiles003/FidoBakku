class FormSection < ActiveRecord::Base
  
  include Upgradable
  
  belongs_to :form
  
  has_many :form_comps, dependent: :destroy
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def next_ordr
    section = ::FormSection.where(form_id: self.form_id).order(ordr: :desc).take
    self.ordr = section.nil? ? 10 : section.ordr + 10
  end
  
end
