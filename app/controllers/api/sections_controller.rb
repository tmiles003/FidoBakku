class Api::SectionsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_form, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  
  before_action :set_section, only: [:update, :up, :down, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_section
  
  before_action :set_section_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_section_above
  before_action :set_section_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_section_below
  
  # GET /api/sections
  # GET /api/sections.json
  def index
    render json: @form.sections
  end

  # POST /api/sections
  # POST /api/sections.json
  def create
    @section = ::Section.new(section_params)
    @section.next_ordr
    @section._account = @account

    if @section.save
      render json: @section, status: :created
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/sections/1
  # PATCH/PUT /api/sections/1.json
  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end
  
  # PUT /api/sections/1/up.json
  def up
    ordr = @section.ordr
    @section.update(ordr: @section_above.ordr)
    @section_above.update(ordr: ordr)
    
    render json: Array.[](@section, @section_above)
  end
  
  # PUT /api/sections/1/down.json
  def down
    ordr = @section.ordr
    @section.update(ordr: @section_below.ordr)
    @section_below.update(ordr: ordr)
    
    render json: Array.[](@section, @section_below)
  end

  # DELETE /api/sections/1
  # DELETE /api/sections/1.json
  def destroy
    @section.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.find(params[:form_id])
    end
    
    def invalid_form
      logger.info 'no form with this id'
      head :no_content
    end
    
    def set_section
      @section = ::Section.find(params[:id])
    end
    
    def invalid_section
      logger.info 'invalid section'
      head :no_content
    end
    
    def set_section_above
      @section_above = ::Section.where(form_id: @section.form_id)
        .where('ordr < ?', @section.ordr).order(ordr: :desc).take!
    end
    
    def invalid_section_above
      logger.info 'invalid section above'
      head :no_content
    end
    
    def set_section_below
      @section_below = ::Section.where(form_id: @section.form_id)
        .where('ordr > ?', @section.ordr).order(ordr: :asc).take!
    end
    
    def invalid_section_below
      logger.info 'invalid section below'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name)
        .merge(form_id: params.require(:form_id))
    end
end
