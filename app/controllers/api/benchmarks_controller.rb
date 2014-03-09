class Api::BenchmarksController < ApplicationController
  
  # before_action :authenticate_user!
  before_action :set_form_section, only: [:index]
  before_action :set_section_benchmark, only: [:update, :destroy]

  # GET /api/forms/:form_id/sections/:section_id/benchmarks
  # GET /api/forms/:form_id/sections/:section_id/benchmarks.json
  def index
    @section_benchmarks = @form_section.form_section_benchmarks
  end
  
  # POST /api/forms/:form_id/sections/:section_id/benchmarks
  # POST /api/forms/:form_id/sections/:section_id/benchmarks.json
  def create
    @section_benchmark = ::FormSectionBenchmark.new(section_benchmark_params)
    @section_benchmark.ordr = 2000

    respond_to do |format|
      if @section_benchmark.save
        format.json { render json: @section_benchmark, status: :created }
      else
        format.json { render json: @section_benchmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/forms/:form_id/sections/:section_id/benchmarks/1
  # PATCH/PUT /api/forms/:form_id/sections/:section_id/benchmarks/1.json
  def update
    respond_to do |format|
      if @section_benchmark.update(section_benchmark_params)
        format.json { render json: @section_benchmark, status: :created }
      else
        format.json { render json: @section_benchmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/forms/:form_id/sections/:section_id/benchmarks/1
  # DELETE /api/forms/:form_id/sections/:section_id/benchmarks/1.json
  def destroy
    @section_benchmark.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_section
      @form_section = ::FormSection.find(params[:section_id])
    end
    
    def set_section_benchmark
      @section_benchmark = ::FormSectionBenchmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_benchmark_params
      params.require(:section_benchmark).permit(:content)
        .merge(section_id: params.require(:section_id))
    end
end
