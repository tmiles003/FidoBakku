class Goal::GoalSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :content, :done, :due_date, :due_date_parts
  
  has_one :user, serializer: ::Goal::UserSerializer
  has_many :comments, serializer: ::Goal::CommentSerializer
  #has_one :evaluation_loop
  
  def due_date_parts
    parts = Hash[ 'm' => nil, 'd' => nil, 'y' => nil ]
    parts['m'] = object.due_date.strftime('%B') unless object.due_date.nil?
    parts['d'] = object.due_date.strftime('%-d') unless object.due_date.nil?
    parts['y'] = object.due_date.strftime('%Y') unless object.due_date.nil?
    
    parts
  end
  
  def evaluation_loop
    evaluation = object.user.evaluations.take
    evaluation_loop = evaluation.evaluation_loop unless evaluation.nil?
    ::Goal::EvaluationLoopSerializer.new(evaluation_loop) # for display only
  end
  
end
