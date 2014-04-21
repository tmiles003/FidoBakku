class Admin::AccountSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :owner_id, :admins, :plan, :expires_at
  
  def admins
    admin_users = current_user.account.users.where(role: 'admin')
      
    ActiveModel::ArraySerializer.new(admin_users, each_serializer: ::Admin::AdminUserSerializer)
  end

end
