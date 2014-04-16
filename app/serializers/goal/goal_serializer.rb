class Goal::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content
  
  has_one :user, serializer: ::Goal::UserSerializer
  has_many :comments, serializer: ::Goal::CommentSerializer
  has_one :evaluation_session
  
  def evaluation_session
    evaluation_session = object.user.evaluations.take.evaluation_session
    ::Goal::EvaluationSessionSerializer.new( evaluation_session )
  end
  
end
