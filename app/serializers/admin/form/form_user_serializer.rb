class Admin::Form::FormUserSerializer < ActiveModel::Serializer
  
  attributes :id, :form_id, :user_id, :assigned
  has_one :user, serializer: ::Admin::FormUserUserSerializer
  
  def assigned
    !!object.form_id
  end
  
end
