class FormComp < ActiveRecord::Base
  
  self.table_name = 'form_competencies'
  
  belongs_to :form_section
  
  def next_ordr
    comp = ::FormComp.where(form_section_id: self.form_section_id).order(ordr: :desc).take
    self.ordr = comp.nil? ? 10 : comp.ordr + 10
  end
  
end
