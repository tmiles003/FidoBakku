class Goal::CommentSerializer < ActiveModel::Serializer
  
  attributes :id, :content, :created_at, :created_at_ts
  has_one :user, serializer: ::Goal::UserSerializer
  
  def created_at
    object.created_at.strftime('%e %b %y, %k:%M') unless object.created_at.nil?
  end
  
  def created_at_ts
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
end
