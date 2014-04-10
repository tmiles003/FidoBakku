class FormPart < ActiveRecord::Base
  
  def self.get_parts form_id
    parts = [form_id]
    current_id = form_id
    
    while r = self.get_part(current_id)
      
      # prevent infinite loop - a part cannot include one that's already included
      break if parts.include?(r.part_id)
      
      parts.unshift r.part_id
      current_id = r.part_id
    end
    
    parts
  end
  
  def self.get_part id
    ::FormPart.where(form_id: id).where.not(part_id: id).take
  end
  
  def self.detect_loop
  end

end
