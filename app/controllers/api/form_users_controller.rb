class Api::FormUsersController < Api::ApiController
  
  #load_and_authorize_resource
  
  before_action :set_form
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form
  before_action :set_form_user, except: [:users]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_form_user
  
  # GET /api/forms/1/users
  # GET /api/forms/1/users.json
  def users
    users = Hash.new
    ::FormUser.where(form_id: @form.id).each { |form_user| 
      users[form_user.user_id] = true
    }
    
    render json: users
  end

  # PATCH/PUT /api/forms/1/assign/1
  # PATCH/PUT /api/forms/1/assign/1.json
  def assign
    @form_user.destroy unless @form_user.nil?
    
    @form_user = ::FormUser.new(form_id: params[:id], user_id: params[:user_id])
    @form_user.save
        
    head :created
  end

  # PATCH/PUT /api/forms/1/remove/1
  # PATCH/PUT /api/forms/1/remove/1.json
  def remove
    @form_user.destroy
    
    head :no_content
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = ::Form.in_account(@account.id).find(params[:id])
    end
    
    def invalid_form
      #logger.info 'invalid_form'
      head :no_content
    end
    
    def set_form_user
      @form_user = ::FormUser.find_or_initialize_by(form_id: params[:id], user_id: params[:user_id])
    end
    
    def invalid_form_user
      #logger.info 'invalid_form_user'
      head :no_content
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_user_params
      params.require(:form_user).permit(:id, :user_id)
    end
    
end
