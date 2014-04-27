class Api::Admin::FormPartsController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_form_part, only: [:update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_part
  
  # PATCH/PUT /api/admin/form_parts/1.json
  def update
    if @form_part.update(form_part_params)
      render json: @form_part, serializer: ::Admin::Form::FormPartSerializer
    else
      render json: @form_part.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_part
      @form_part = ::FormPart.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_form_part
      logger.error 'No form part with this id'
      head :no_content
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def form_part_params
      params.require(:form_part).permit(:part_id)
    end
end
