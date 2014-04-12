class Api::Admin::FormCompsController < Api::ApiController
  
  before_action :set_form_section, only: [:index, :create]
  before_action :set_form_comp, only: [:update, :up, :down, :destroy]
  
  before_action :set_comp_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_above
  before_action :set_comp_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_below

  # GET /api/admin/form_sections/:form_section_id/form_comps.json
  def index
    render json: @form_section.form_comps, each_serializer: ::Admin::FormCompSerializer
  end
  
  # POST /api/admin/form_comps.json
  def create
    @form_comp = ::FormComp.new(form_comp_params)
    @form_comp.next_ordr

    if @form_comp.save
      @form_section.form_comps << @form_comp
      render json: @form_comp, status: :created, serializer: ::Admin::FormCompSerializer
    else
      render json: @form_comp.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/admin/form_comps/1.json
  def update
    if @form_comp.update(form_comp_params)
      render json: @form_comp, status: :created, serializer: ::Admin::FormCompSerializer
    else
      render json: @form_comp.errors, status: :unprocessable_entity
    end
  end
  
  # PUT /api/admin/form_comps/1/up.json
  def up
    ordr = @form_comp.ordr
    @form_comp.update(ordr: @form_comp_above.ordr)
    @form_comp_above.update(ordr: ordr)
    
    render json: Array.[](@form_comp, @form_comp_above), each_serializer: ::Admin::FormCompSerializer
  end
  
  # PUT /api/admin/form_comps/1/down.json
  def down
    ordr = @form_comp.ordr
    @form_comp.update(ordr: @form_comp_below.ordr)
    @form_comp_below.update(ordr: ordr)
    
    render json: Array.[](@form_comp, @form_comp_below), each_serializer: ::Admin::FormCompSerializer
  end

  # DELETE /api/admin/comps/1.json
  def destroy
    @form_comp.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_section
      @form_section = ::FormSection.find(params[:form_section_id])
    end
    
    def set_form_comp
      @form_comp = ::FormComp.find(params[:id])
    end
    
    def invalid_form_comp
      logger.info 'no comp with this id'
      head :no_content
    end
    
    def set_comp_above
      @form_comp_above = ::FormComp.where(form_section_id: @form_comp.form_section_id)
        .where('ordr < ?', @form_comp.ordr).order(ordr: :desc).take
    end
    
    def invalid_comp_above
      logger.info 'invalid comp above'
      head :no_content
    end
    
    def set_comp_below
      @form_comp_below = ::FormComp.where(form_section_id: @form_comp.form_section_id)
        .where('ordr > ?', @form_comp.ordr).order(ordr: :asc).take
    end
    
    def invalid_comp_below
      logger.info 'invalid comp below'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_comp_params
      params.require(:form_comp).permit(:content)
        .merge(form_section_id: params.require(:form_section_id))
    end
end