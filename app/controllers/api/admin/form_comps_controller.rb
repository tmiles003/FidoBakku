class Api::Admin::FormCompsController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_form_section, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_section
  
  before_action :set_form_comp, only: [:update, :up, :down, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_comp
  
  before_action :set_comp_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_above
  before_action :set_comp_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_below

  # POST /api/admin/form_comps.json
  def create
    @form_comp = ::FormComp.new(form_comp_params)
    @form_comp.account = current_user.account
    @form_comp.form_section = @form_section
    @form_comp.next_ordr

    if @form_comp.save
      render json: @form_comp, status: :created, serializer: ::Admin::Form::CompSerializer
    else
      render json: @form_comp.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/form_comps/1.json
  def update
    if @form_comp.update(form_comp_params)
      render json: @form_comp, status: :created, serializer: ::Admin::Form::CompSerializer
    else
      render json: @form_comp.errors, status: :unprocessable_entity
    end
  end
  
  # PUT /api/admin/form_comps/1/up.json
  def up
    ordr = @form_comp.ordr
    @form_comp.update(ordr: @form_comp_above.ordr)
    @form_comp_above.update(ordr: ordr)
    
    render json: Array.[](@form_comp, @form_comp_above), each_serializer: ::Admin::Form::CompSerializer
  end
  
  # PUT /api/admin/form_comps/1/down.json
  def down
    ordr = @form_comp.ordr
    @form_comp.update(ordr: @form_comp_below.ordr)
    @form_comp_below.update(ordr: ordr)
    
    render json: Array.[](@form_comp, @form_comp_below), each_serializer: ::Admin::Form::CompSerializer
  end

  # DELETE /api/admin/comps/1.json
  def destroy
    @form_comp.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_section
      @form_section = ::FormSection.in_account(current_user.account.id).find(params[:section_id])
    end
    
    def invalid_form_section
      logger.error "No form section with this id: #{params[:section_id]}"
      error = Hash['error', [t('admin.form_sections.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_form_comp
      @form_comp = ::FormComp.in_account(current_user.account.id).find(params[:id])
    end
    
    def invalid_form_comp
      logger.error "No form competency with this id: #{params[:id]}"
      error = Hash['error', [t('admin.form_comps.record_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_comp_above
      @form_comp_above = ::FormComp.where(form_section_id: @form_comp.form_section_id)
        .where('ordr < ?', @form_comp.ordr).order(ordr: :desc).take
    end
    
    def invalid_comp_above
      logger.error "Form competency above not found"
      error = Hash['error', [t('admin.form_comps.above_not_found')]]
      render json: error, status: :not_found
    end
    
    def set_comp_below
      @form_comp_below = ::FormComp.where(form_section_id: @form_comp.form_section_id)
        .where('ordr > ?', @form_comp.ordr).order(ordr: :asc).take
    end
    
    def invalid_comp_below
      logger.error "Form competency below not found"
      error = Hash['error', [t('admin.form_comps.below_not_found')]]
      render json: error, status: :not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_comp_params
      params.require(:form_comp).permit(:content)
    end
end
