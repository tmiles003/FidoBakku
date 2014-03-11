class Api::TopicsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_form, only: [:index] # revisit this method
  before_action :set_topic, only: [:update, :destroy]
  
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
    
    def set_topic
      @topic = ::Topic.find(params[:id])
    end
    
    def invalid_form
      head :no_content
    end
    
    def invalid_topic
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :ordr)
        .merge(form_id: params.require(:form_id))
    end
end
