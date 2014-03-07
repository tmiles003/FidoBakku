class Api::FormsController < ApplicationController
  
  before_action :set_api_form, only: [:show, :edit, :update, :destroy]

  # GET /api/forms
  # GET /api/forms.json
  def index
    @api_forms = Api::Form.all
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
    @api_form = Api::Form.new(api_form_params)

    respond_to do |format|
      if @api_form.save
        format.html { redirect_to @api_form, notice: 'Form was successfully created.' }
        format.json { render action: 'show', status: :created, location: @api_form }
      else
        format.html { render action: 'new' }
        format.json { render json: @api_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/forms/1
  # PATCH/PUT /api/forms/1.json
  def update
    respond_to do |format|
      if @api_form.update(api_form_params)
        format.html { redirect_to @api_form, notice: 'Form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @api_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/forms/1
  # DELETE /api/forms/1.json
  def destroy
    @api_form.destroy
    respond_to do |format|
      format.html { redirect_to api_forms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_form
      @api_form = Api::Form.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_form_params
      params.require(:api_form).permit(:account_id, :name)
    end
end
