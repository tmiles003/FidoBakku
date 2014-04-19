class Goal::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content, :due_date
  
  has_one :user, serializer: ::Goal::UserSerializer
  has_many :comments, serializer: ::Goal::CommentSerializer
  has_one :evaluation_session
  
  def evaluation_session
    evaluation = object.user.evaluations.take
    evaluation_session = evaluation.evaluation_session unless evaluation.nil?
    ::Goal::EvaluationSessionSerializer.new( evaluation_session ) # for display only
  end
  
end
