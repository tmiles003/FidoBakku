class AccountController < ApplicationController
  before_action :set_account, only: [:edit, :update, :destroy]

  # GET /account/new
  def new
    @account = Account.new
    @url = account_index_path(@account)
  end

  # GET /account/1/edit
  def edit
    @url = account_path(@account)
  end

  # POST /account
  # POST /account.json
  def create
    @account = Account.new(account_params)
    
    hash = OpenSSL::Digest::MD5.new(Time.new.strftime('%c') << Rails.configuration.secret_key_base)
    
    @user = User.new
    @user.email = account_params[:email]
    @user.password = hash.hexdigest[0..12]
    @user.name = 'New User'
    @user.role = 'admin'
    @user.save

    respond_to do |format|
      if @account.save
        @account.users << @user
        sign_in @user
        format.html { redirect_to authenticated_root_path, notice: 'Account was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        #format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account/1
  # PATCH/PUT /account/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to edit_account_path @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account/1
  # DELETE /account/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:email, :name)
    end
end
