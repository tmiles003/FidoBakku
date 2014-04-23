class Admin::Form::FormUserSerializer < ActiveModel::Serializer
  
  attributes :id, :form_id, :user_id, :name, :team_id
  #has_one :user, serializer: ::Admin::Form::FormUserUserSerializer
  
  def name
    object.user.name
  end
  
  def team_id
    object.user.team.nil? ? nil : object.user.team.id
  end
  
end
