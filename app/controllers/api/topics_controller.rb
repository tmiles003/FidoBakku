class Api::TopicsController < Api::ApiController
  
  before_action :set_form, only: [:index] # revisit this method
  before_action :set_topic, only: [:update, :up, :down, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_topic
  before_action :set_topic_above, only: [:up]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_topic_above
  before_action :set_topic_below, only: [:down]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_topic_below
  
  # GET /api/topics
  # GET /api/topics.json
  def index
    @topics = @form.topics
  end

  # POST /api/topics
  # POST /api/topics.json
  def create
    @topic = ::Topic.new(topic_params)
    @topic.ordr = 2000

    respond_to do |format|
      if @topic.save
        format.json { render json: @topic, status: :created }
      else
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/topics/1
  # PATCH/PUT /api/topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.json { render json: @topic, status: :created }
      else
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /api/topics/1/up.json
  def up
    ordr = @topic.ordr
    @topic.update(ordr: @topic_above.ordr)
    @topic_above.update(ordr: ordr)
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
  # POST /api/topics/1/down.json
  def down
    ordr = @topic.ordr
    @topic.update(ordr: @topic_below.ordr)
    @topic_below.update(ordr: ordr)
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # DELETE /api/topics/1
  # DELETE /api/topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.find(params[:form_id])
    end
    
    def invalid_form
      head :no_content
    end
    
    def set_topic
      @topic = ::Topic.find(params[:id])
    end
    
    def invalid_topic
      logger.info 'invalid topic'
      head :no_content
    end
    
    def set_topic_above
      @topic_above = ::Topic.where(form_id: @topic.form_id)
        .where('ordr < ?', @topic.ordr).order(ordr: :desc).take!
    end
    
    def invalid_topic_above
      logger.info 'invalid topic above'
      head :no_content
    end
    
    def set_topic_below
      @topic_below = ::Topic.where(form_id: @topic.form_id)
        .where('ordr > ?', @topic.ordr).order(ordr: :asc).take!
    end
    
    def invalid_topic_below
      logger.info 'invalid topic below'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :ordr)
        .merge(form_id: params.require(:form_id))
    end
end
