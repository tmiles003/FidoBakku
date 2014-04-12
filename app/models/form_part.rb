class FormPart < ActiveRecord::Base
  
  def self.get_parts form_id
    parts = []
    part_ids = Hash.new
    
    ordr = 10
    current_id = form_id

    parts << Hash['ordr' => ordr, 'form_id' => current_id]
    part_ids[current_id]
    
    while fp = ::FormPart.where(form_id: current_id).where.not(part_id: current_id).take
      # prevent infinite loop - a part cannot include one that's already included
      break if part_ids.has_value?(fp.part_id)
      
      ordr += 10
      current_id = fp.part_id
      parts << Hash['ordr' => ordr, 'form_id' => current_id]
      part_ids[current_id]
    end
    
    parts
  end
  
end
