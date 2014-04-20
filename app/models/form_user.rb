class FormUser < ActiveRecord::Base
  
  belongs_to :form
  belongs_to :user #, primary_key: :user_id
  
  def self.users(form_id)
    users = Hash.new
    ::FormUser.where(form_id: form_id).each { |form_user| 
      users[form_user.user_id] = true
    }
    
    users
  end
  
end