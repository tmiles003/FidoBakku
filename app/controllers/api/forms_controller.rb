class Api::FormsController < ApplicationController
  
  before_action :set_current_user
  before_action :set_form, only: [:edit, :update, :destroy]

  # GET /api/forms
  # GET /api/forms.json
  def index
    @account = @current_user.account
    @forms = @account.forms
  end

  # GET /api/forms/1
  # GET /api/forms/1.json
  def show
  end

  # GET /api/forms/1/edit
  def edit
  end

  # POST /api/forms
  # POST /api/forms.json
  def create
    @form = Form.new(form_params)
    @form.account_id = @current_user.account.id

    respond_to do |format|
      if @form.save
        format.json { render json: @form, status: :created }
      else
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/forms/1
  # PATCH/PUT /api/forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.json { head :no_content }
      else
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/forms/1
  # DELETE /api/forms/1.json
  def destroy
    @form.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user
      @current_user = current_user
    end
    
    def set_form
      @form = Form.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name)
    end
end
