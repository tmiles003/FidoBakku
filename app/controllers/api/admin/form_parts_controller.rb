class Api::Admin::FormPartsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_form, only: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  before_action :set_form_part, only: [:update, :destroy]
  
  # GET /api/admin/form_parts.json
  def index
    @form_part = ::FormPart.where(form_id: params[:form_id]).where.not(part_id: params[:form_id]).take
    @form_part ||= ::FormPart.new(form_id: params[:form_id])
    
    render json: @form_part, serializer: ::Admin::FormPartSerializer
  end
  
  # POST /api/admin/form_parts.json
  def create
    @form_part = ::FormPart.new(form_part_params)
    
    if @form_part.save
      render json: @form_part, serializer: ::Admin::FormPartSerializer
    else
      render json: @form_part.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /api/admin/form_parts/1.json
  def update
    if @form_part.update(form_part_params)
      render json: @form_part, serializer: ::Admin::FormPartSerializer
    else
      render json: @form_part.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/admin/form_parts/1.json
  def destroy
    @form_part.destroy
    render json: ::FormPart.new(form_id: @form_part.form_id)
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
    
    def set_form_part
      @form_part = ::FormPart.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def form_part_params
      params.require(:form_part).permit(:form_id, :part_id)
    end
end
