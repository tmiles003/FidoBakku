class PeopleController < ApplicationController
  
  before_action :authenticate_user!
  
  include PeopleHelper
  
  # GET /people
  def index
  end
  
end
