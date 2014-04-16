class Goal::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content
  
  has_one :user, serializer: ::Goal::UserSerializer
  has_many :comments, serializer: ::Goal::CommentSerializer
  
end
