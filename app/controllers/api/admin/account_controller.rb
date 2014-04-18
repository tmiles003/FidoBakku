class Api::Admin::AccountController < Api::ApiController
  
  #authorize_resource
  
  # GET /api/account.json
  def show
  end
  
  # PATCH/PUT /api/account.json
  def update
    if @account.update(account_params)
      head :no_content
    else
      render json: @account.errors
    end
  end
  
  # DELETE
  # laterrr. cos special case
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.required(:account).permit(:name, :owner_id)
    end
  
end