class Api::FormSectionsController < ApplicationController
  
  # before_action :authenticate_user!
  before_action :set_form, only: [:index]
  before_action :set_form_section, only: [:update, :destroy]
  
  # GET /api/forms/:form_id/form_sections
  # GET /api/forms/:form_id/form_sections.json
  def index
    @form_sections = @form.form_sections
  end

  # POST /api/form_sections
  # POST /api/form_sections.json
  def create
    @form_section = ::FormSection.new(form_section_params)
    logger.info form_section_params.to_yaml
    # @form_section.form_id = 

    respond_to do |format|
      if @form_section.save
        format.json { render json: @form_section, status: :created }
      else
        format.json { render json: @form_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/form_sections/1
  # PATCH/PUT /api/form_sections/1.json
  def update
    respond_to do |format|
      if @form_section.update(form_section_params)
        format.json { render json: @form_section, status: :created }
      else
        format.json { render json: @form_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/form_sections/1
  # DELETE /api/form_sections/1.json
  def destroy
    @form_section.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.find(params[:form_id])
    end
    
    def set_form_section
      @form_section = ::FormSection.find(params[:id])
    end
    
    def invalid_form
      head :no_content
    end
    
    def invalid_form_section
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_section_params
      params.require(:form_section).permit(:name, :ordr).merge(form_id: params.require(:form_id))
    end
end
