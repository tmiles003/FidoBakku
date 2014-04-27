class FormUser < ActiveRecord::Base
  
  include InAccount
  
  belongs_to :account
  
  belongs_to :form
  belongs_to :user #, primary_key: :user_id
  
end