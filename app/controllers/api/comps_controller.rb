class Api::CompsController < Api::ApiController
  
  before_action :set_section, only: [:index, :create]
  before_action :set_comp, only: [:update, :up, :down, :destroy]
  #
  before_action :set_comp_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_above
  before_action :set_comp_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_comp_below

  # GET /api/sections/:section_id/comps
  # GET /api/sections/:section_id/comps.json
  def index
    render json: @section.comps
  end
  
  # POST /api/comps
  # POST /api/comps.json
  def create
    @comp = ::Comp.new(comp_params)
    @comp.next_ordr
    @comp._account = @account

    respond_to do |format|
      if @comp.save
        @section.comps << @comp
        format.json { render json: @comp, status: :created }
      else
        format.json { render json: @comp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/comps/1
  # PATCH/PUT /api/comps/1.json
  def update
    respond_to do |format|
      if @comp.update(comp_params)
        format.json { render json: @comp, status: :created }
      else
        format.json { render json: @comp.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /api/comps/1/up.json
  def up
    ordr = @comp.ordr
    @comp.update(ordr: @comp_above.ordr)
    @comp_above.update(ordr: ordr)
    
    @comps = Array.[](@comp, @comp_above)
    
    respond_to do |format|
      format.json { render json: @comps }
    end
  end
  
  # PUT /api/comps/1/down.json
  def down
    ordr = @comp.ordr
    @comp.update(ordr: @comp_below.ordr)
    @comp_below.update(ordr: ordr)
    
    @comps = Array.[](@comp, @comp_below)
    
    respond_to do |format|
      format.json { render json: @comps }
    end
  end

  # DELETE /api/comps/1
  # DELETE /api/comps/1.json
  def destroy
    @comp.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = ::Section.find(params[:section_id])
    end
    
    def set_comp
      @comp = ::Comp.find(params[:id])
    end
    
    def invalid_comp
      logger.info 'invalid comp'
      head :no_content
    end
    
    def set_comp_above
      @comp_above = ::Comp.where(section_id: @comp.section_id)
        .where('ordr < ?', @comp.ordr).order(ordr: :desc).take!
    end
    
    def invalid_comp_above
      logger.info 'invalid comp above'
      head :no_content
    end
    
    def set_comp_below
      @comp_below = ::Comp.where(section_id: @comp.section_id)
        .where('ordr > ?', @comp.ordr).order(ordr: :asc).take!
    end
    
    def invalid_comp_below
      logger.info 'invalid comp below'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comp_params
      params.require(:comp).permit(:content)
        .merge(section_id: params.require(:section_id))
    end
end
