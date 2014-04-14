class AccountController < ApplicationController
  
  # GET /account/new
  def new
    @account = Account.new
    @url = account_index_path(@account)
  end

  # POST /account
  # POST /account.json
  def create
    @account = Account.new(account_params)
    
    respond_to do |format|
      if @account.save
        
        @user = User.new(email: account_params[:email])
        #@user._account = @account
        @account.users << @user # assign to account
        @user.update(name: 'Admin', role: 'admin') # promote
        @account.update(owner_id: @user.id)
        sign_in @user
        
        # send welcome email
        
        format.html { redirect_to root_path }
      else
        @url = account_index_path(@account)
        format.html { render action: 'new' }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:email)
    end
end
