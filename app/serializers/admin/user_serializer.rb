class Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :email_hash, :name, :team_id, :role, :role_sort, :user_path
  has_one :form
  #has_one :team, serializer: ::Admin::TeamSerializer
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
  def team_id
    object.team.nil? ? nil : object.team.id
  end
  
  # allows group sorting in evaluations user picker
  def role_sort
    if 'employee' == object.role 
      10
    elsif 'manager' == object.role 
      20
    else # admin
      30
    end
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
