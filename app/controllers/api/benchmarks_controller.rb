class Api::BenchmarksController < Api::ApiController
  
  before_action :set_topic, only: [:index, :create]
  before_action :set_benchmark, only: [:update, :destroy]

  # GET /api/topics/:topic_id/benchmarks
  # GET /api/topics/:topic_id/benchmarks.json
  def index
    @benchmarks = @topic.benchmarks
  end
  
  # POST /api/benchmarks
  # POST /api/benchmarks.json
  def create
    @benchmark = ::TopicBenchmark.new(benchmark_params)
    @benchmark.ordr = 2000

    respond_to do |format|
      if @benchmark.save
        @topic.benchmarks << @benchmark
        format.json { render json: @benchmark, status: :created }
      else
        format.json { render json: @benchmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/benchmarks/1
  # PATCH/PUT /api/benchmarks/1.json
  def update
    respond_to do |format|
      if @benchmark.update(benchmark_params)
        format.json { render json: @benchmark, status: :created }
      else
        format.json { render json: @benchmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/benchmarks/1
  # DELETE /api/benchmarks/1.json
  def destroy
    @benchmark.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = ::Topic.find(params[:topic_id])
    end
    
    def set_benchmark
      @benchmark = ::TopicBenchmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benchmark_params
      params.require(:benchmark).permit(:content)
        .merge(topic_id: params.require(:topic_id))
    end
end
