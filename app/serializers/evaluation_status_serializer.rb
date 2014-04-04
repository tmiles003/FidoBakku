class EvaluationStatusSerializer < ActiveModel::Serializer
  attributes :s, :l 
  
  def s
    object
  end
  
  def l
    object.capitalize
  end
end
