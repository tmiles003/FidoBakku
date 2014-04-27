class Api::FormCompController < Api::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_form_comp, only: [:update]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_comp
  
  # PATCH/PUT /api/form_comp/1.json
  def update
    @form_comp.update(in_use: true)
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_comp
      @form_comp = ::FormComp.find(params[:id]) #.in_account()
    end
    
    def invalid_form_comp
      logger.error "No form comp with this id: #{params[:id]}"
      render nothing: true
    end
    
end
