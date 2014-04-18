class Admin::FormUserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :team_id
  has_one :form, serializer: ::Admin::UserFormSerializer
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
end
