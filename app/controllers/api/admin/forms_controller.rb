class Api::Admin::FormsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_form, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form

  # GET /api/admin/forms.json
  def index
    render json: @user.account.forms.sharable(params[:shared]), each_serializer: ::Admin::FormSerializer
  end
  
  # GET /api/admin/forms/1.json
  def show
    render json: @form, serializer: ::Admin::FormSerializer
  end
  
  # POST /api/admin/forms.json
  def create
    @form = ::Form.new(form_params) # :: forces root namespace
    @form.account = @user.account

    if @form.save
      render json: @form, status: :created, serializer: ::Admin::FormSerializer
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/forms/1.json
  def update
    if @form.update(form_params)
      render json: @form, serializer: ::Admin::FormSerializer
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/admin/forms/1.json
  def destroy
    @form.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.in_account(@user.account.id).find(params[:id])
    end
    
    def invalid_form
      logger.warn 'no form with this id'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name, :shared)
    end
end
