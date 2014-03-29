class Api::FormsController < Api::ApiController
  
  load_and_authorize_resource
  
  before_action :set_form, only: [:update, :user, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form

  # GET /api/forms
  # GET /api/forms.json
  def index
    @forms = @account.forms
  end
  
  # GET /api/forms/list
  # GET /api/forms/list.json
  def list
    @account = @current_user.account
    @forms = @account.forms
  end

  # POST /api/forms
  # POST /api/forms.json
  def create
    @form = ::Form.new(form_params) # :: forces root namespace
    @form.account_id = @account.id
    @form._account = @account

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
  
  # PATCH/PUT /api/forms/1/user/1
  # PATCH/PUT /api/forms/1/user/1.json
  def user
    @form_user = ::User.find(params[:user_id])
    #logger.info 'assigning form to user'
    # clear any existing assignments
    
    # assign
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
    def set_form
      @form = ::Form.in_account(@account.id).find(params[:id])
    end
    
    def invalid_form
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_params
      params.require(:form).permit(:name)
    end
end
