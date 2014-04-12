class Feedback::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_id, :ratings
  has_one :user
  
  def ratings
    mine = ::UserEvaluation.user_ratings object.id, object.user_id
    peers = ::UserEvaluation.user_ratings object.id, object.user_id, ['user']
    manager = ::UserEvaluation.user_ratings object.id, object.user_id, ['manager','admin']
    
    ratings = Hash.new
    ratings['mine'] = mine
    ratings['peers'] = peers
    ratings['manager'] = manager
    
    ratings
  end
  
end
