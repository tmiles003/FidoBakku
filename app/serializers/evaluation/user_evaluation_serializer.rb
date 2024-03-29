class Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress, :ratings
  has_one :evaluation, serializer: ::Evaluation::EvaluationSerializer
  has_one :comment, serializer: ::Evaluation::CommentSerializer
  
  def progress
    sprintf('%.2e', object.progress * Math::PI / 50).to_f
  end
  
  def comment
    ::Comment.find_or_create_by(user_id: scope.id, user_evaluation_id: object.id)
  end
  
end
