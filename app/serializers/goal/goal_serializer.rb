class Goal::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content, :due_date
  
  has_one :user, serializer: ::Goal::UserSerializer
  has_many :comments, serializer: ::Goal::CommentSerializer
  has_one :evaluation_loop
  
  def evaluation_loop
    evaluation = object.user.evaluations.take
    evaluation_loop = evaluation.evaluation_loop unless evaluation.nil?
    ::Goal::EvaluationLoopSerializer.new(evaluation_loop) # for display only
  end
  
end
