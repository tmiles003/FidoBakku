class FormSection < ActiveRecord::Base
  
  belongs_to :form
  
  has_many :form_section_benchmarks, dependent: :destroy, foreign_key: :section_id
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
end
