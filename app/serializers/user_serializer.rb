class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :email_hash, :name, :role, :role_sort, :team, :form, :user_path
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
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
  
  def team
    object.team.nil? ? nil : object.team
  end
  
  def form
    object.form.nil? ? nil : object.form
  end
  
  def user_path
    root_path(anchor: user_manage_path(object))
  end
  
end
