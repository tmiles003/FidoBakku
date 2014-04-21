class Api::Admin::AccountController < Api::Admin::ApiController
  
  authorize_resource
  
  prepend_before_filter :set_account
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_account
  
  # GET /api/admin/account.json
  def show
    render json: @account, serializer: ::Admin::AccountSerializer
  end
  
  # PATCH/PUT /api/admin/account.json
  def update
    if @account.update(account_params)
      render json: @account, serializer: ::Admin::AccountSerializer
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/admin/account
  def destroy
    @account.destroy
    session = nil
    flash[:notice] = 'Account deleted'
    render nothing: true, status: :ok
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.account unless current_user.nil?
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