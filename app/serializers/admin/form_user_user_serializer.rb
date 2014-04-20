class Admin::FormUserUserSerializer < ActiveModel::Serializer
  
  attributes :name, :team_id
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
end
