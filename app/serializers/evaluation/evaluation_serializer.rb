class Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :form_parts
  has_one :user, serializer: ::BaseUserSerializer
  
  def form_parts
    forms = []
    ::FormPart.get_parts(object.form_id).each { |part|
      form = ::Form.where(id: part['form_id']).includes(form_sections: :form_comps).take
      form.ordr = part['ordr']
      
      forms << form
    }
    
    ActiveModel::ArraySerializer.new(forms, each_serializer: ::Form::FormSerializer)
  end
  
end
