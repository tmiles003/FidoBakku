class UserEvaluationFormSerializer < ActiveModel::Serializer
  attributes :parts
  
  def parts
    ::FormPart::get_parts object.id
    
  end
  
end
