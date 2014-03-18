class Api::BenchmarksController < Api::ApiController
  
  before_action :set_topic, only: [:index, :create]
  before_action :set_benchmark, only: [:update, :up, :down, :destroy]
  #
  before_action :set_benchmark_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_benchmark_above
  before_action :set_benchmark_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_benchmark_below

  # GET /api/topics/:topic_id/benchmarks
  # GET /api/topics/:topic_id/benchmarks.json
  def index
    @benchmarks = @topic.benchmarks
  end
  
  # POST /api/benchmarks
  # POST /api/benchmarks.json
  def create
    @benchmark = ::TopicBenchmark.new(benchmark_params)
    @benchmark.next_ordr

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
  
  # POST /api/benchmarks/1/up.json
  def up
    ordr = @benchmark.ordr
    @benchmark.update(ordr: @benchmark_above.ordr)
    @benchmark_above.update(ordr: ordr)
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  # POST /api/benchmarks/1/down.json
  def down
    ordr = @benchmark.ordr
    @benchmark.update(ordr: @benchmark_below.ordr)
    @benchmark_below.update(ordr: ordr)
    
    respond_to do |format|
      format.json { head :no_content }
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
    
    def invalid_benchmark
      logger.info 'invalid benchmark'
      head :no_content
    end
    
    def set_benchmark_above
      @benchmark_above = ::TopicBenchmark.where(topic_id: @benchmark.topic_id)
        .where('ordr < ?', @benchmark.ordr).order(ordr: :desc).take!
    end
    
    def invalid_benchmark_above
      logger.info 'invalid benchmark above'
      head :no_content
    end
    
    def set_benchmark_below
      @benchmark_below = ::TopicBenchmark.where(topic_id: @benchmark.topic_id)
        .where('ordr > ?', @benchmark.ordr).order(ordr: :asc).take!
    end
    
    def invalid_benchmark_below
      logger.info 'invalid benchmark below'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def benchmark_params
      params.require(:benchmark).permit(:content)
        .merge(topic_id: params.require(:topic_id))
    end
end
