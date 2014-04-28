class Feedback::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_parts, :ratings
  has_one :user, serializer: ::Feedback::UserSerializer
  has_one :comment, serializer: ::Feedback::CommentSerializer
  
  def form_parts
    forms = []
    ::FormPart.get_parts(object.form_id).each { |part|
      form = ::Form.where(id: part['form_id']).includes(form_sections: :form_comps).take
      form.ordr = part['ordr']
      
      forms << form
    }
    
    ActiveModel::ArraySerializer.new(forms, each_serializer: ::Form::FormSerializer)
  end
  
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
