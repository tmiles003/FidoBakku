class Api::Admin::AccountController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_account
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_account
  
  # GET /api/account.json
  def show
    render json: @account
  end
  
  # PATCH/PUT /api/account.json
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors
    end
  end
  
  # DELETE
  # laterrr. cos special case
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.account
    end
    
    def invalid_account
      logger.error 'No account with this id'
      ## redirect to dashboard
      head :no_content
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.required(:account).permit(:name, :owner_id)
    end
  
end