class FormsController < ApplicationController
  
  # before_action :authenticate_user!
  before_action :set_form, only: [:edit]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  
  def index
  end

  def edit
  end
  
  private
    
    def set_form
      @account = current_user.account
      @form = ::Form.in_account(@account.id).find(params[:id])
    end
    
    def invalid_form
      redirect_to forms_path, notice: 'This form does not exist'
    end
  
end
