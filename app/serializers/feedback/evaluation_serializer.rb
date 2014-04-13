class Feedback::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_id, :ratings
  has_one :user
  has_one :comment, serializer: ::Feedback::CommentSerializer
  
  def ratings
    mine = ::UserEvaluation.user_ratings object.id, object.form_id, object.user_id
    peers = ::UserEvaluation.user_ratings object.id, object.form_id, object.user_id, ['user']
    manager = ::UserEvaluation.user_ratings object.id, object.form_id, object.user_id, ['manager','admin']
    
    ratings = Hash.new
    ratings['mine'] = mine
    ratings['peers'] = peers
    ratings['manager'] = manager
    
    ratings
  end
  
  def comment
    ::Comment.find_or_create_by(evaluation_id: object.id)
  end
  
end
