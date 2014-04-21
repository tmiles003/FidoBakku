class Api::Admin::FormSectionsController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_form, only: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  
  before_action :set_form_section, only: [:update, :up, :down, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_section
  
  before_action :set_section_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_section_above
  before_action :set_section_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_section_below
  
  # GET /api/admin/form_sections.json
  def index
    logger.error 'this should not be in use (Api::Admin::FormSectionsController#index)'
    render json: @form.form_sections, each_serializer: ::Admin::Form::SectionSerializer
  end

  # POST /api/admin/form_sections.json
  def create
    @form_section = ::FormSection.new(form_section_params)
    @form_section.next_ordr # move to model callback

    if @form_section.save
      render json: @form_section, status: :created, serializer: ::Admin::Form::SectionSerializer
    else
      render json: @form_section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/form_sections/1.json
  def update
    if @form_section.update(form_section_params)
      render json: @form_section, serializer: ::Admin::Form::SectionSerializer
    else
      render json: @form_section.errors, status: :unprocessable_entity
    end
  end
  
  # PUT /api/admin/form_sections/1/up.json
  def up
    ordr = @form_section.ordr
    @form_section.update(ordr: @form_section_above.ordr)
    @form_section_above.update(ordr: ordr)
    
    render json: Array.[](@form_section, @form_section_above), each_serializer: ::Admin::Form::SectionSerializer
  end
  
  # PUT /api/admin/form_sections/1/down.json
  def down
    ordr = @form_section.ordr
    @form_section.update(ordr: @form_section_below.ordr)
    @form_section_below.update(ordr: ordr)
    
    render json: Array.[](@form_section, @form_section_below), each_serializer: ::Admin::Form::SectionSerializer
  end

  # DELETE /api/admin/form_sections/1.json
  def destroy
    @form_section.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.in_account(current_user.account.id).find(params[:form_id])
    end
    
    def invalid_form
      logger.error "No form with this id: #{params[:form_id]}"
      error = Hash['error', [t('admin.forms.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_form_section
      @form_section = ::FormSection.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_form_section
      logger.error "No form section with this id: #{params[:id]}"
      error = Hash['error', [t('admin.form_sections.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_section_above
      @form_section_above = ::FormSection.where(form_id: @form_section.form_id)
        .where('ordr < ?', @form_section.ordr).order(ordr: :desc).take
    end
    
    def invalid_section_above
      logger.error "Section above invalid"
      error = Hash['error', [t('admin.form_sections.above_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_section_below
      @form_section_below = ::FormSection.where(form_id: @form_section.form_id)
        .where('ordr > ?', @form_section.ordr).order(ordr: :asc).take
    end
    
    def invalid_section_below
      logger.error "Section below invalid"
      error = Hash['error', [t('admin.form_sections.below_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_section_params
      params.require(:form_section).permit(:name)
        .merge(form_id: params.require(:form_id))
    end
end
