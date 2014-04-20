class WelcomeController < ApplicationController
  
  before_action :authenticate_user!, only: [:application]
  
  def index
  end
  
  def done
  end
  
  def application
  end
  
end
