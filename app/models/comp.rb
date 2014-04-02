class Comp < ActiveRecord::Base
  
  self.table_name = 'competencies'
  
  include Upgradable
  
  belongs_to :section
  
  before_validation :check_plan_comps, on: :create
  
  def next_ordr
    comp = ::Comp.where(section_id: self.section_id).order(ordr: :desc).take
    self.ordr = comp.nil? ? 10 : comp.ordr + 10
  end
  
end
