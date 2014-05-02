class Evaluation::ProgressSerializer < ActiveModel::Serializer
  
  attributes :progress
  
  def progress
    sprintf('%.2e', object.progress * Math::PI / 50).to_f
  end
  
end
