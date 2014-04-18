class Admin::FormUserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :team_id, :form
  has_one :form, serializer: ::Admin::FormUserSerializer
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
end
