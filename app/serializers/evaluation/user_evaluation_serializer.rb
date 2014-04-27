class Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress, :ratings
  has_one :evaluation, serializer: ::Evaluation::EvaluationSerializer
  #has_one :comment, serializer: ::Evaluation::CommentSerializer
  
  def comment
    ::Comment.find_or_create_by(user_evaluation_id: object.id)
  end
  
end
