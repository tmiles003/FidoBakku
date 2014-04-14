class Goal::CommentSerializer < ActiveModel::Serializer
  
  attributes :id, :content, :created_at
  has_one :user, serializer: ::Goal::UserSerializer
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
end
