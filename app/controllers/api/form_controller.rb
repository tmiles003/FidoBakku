class Api::FormController < Api::ApiController
  
  #authorize_resource
  
  before_action :set_form
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  
  def index
    forms = []
    
    ::FormPart.get_parts(@form.id).each { |part|
      form = ::Form.where(id: part['form_id']).includes(form_sections: :form_comps).take
      form.ordr = part['ordr']
      
      forms << form
    }
    
    render json: forms, each_serializer: ::Form::FormSerializer
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.in_account(@user.account.id).find(params[:form_id])
    end
    
    def invalid_form
      logger.info 'no form with this id'
      head :no_content
    end
  
end
