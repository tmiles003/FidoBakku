class Admin::Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :teams, :users
  # session - for return url
  has_one :user, serializer: BaseUserSerializer
  has_many :user_evaluations, serializer: ::Admin::Evaluation::UserEvaluationSerializer
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def manage_path
    root_path(anchor: admin_evaluation_manage_path(object))
  end
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = ::User.in_account(scope.account.id).includes(:team)
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Admin::Evaluation::UserSerializer)
  end
  
  def user_evaluations
    user_evaluations = ::UserEvaluation.where(evaluation_id: object.id).includes(:evaluator)
  end
  
  # , :due_date, :due_date_ts
  
  def due_date
    object.due_date.strftime('%e %B %Y').strip unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
end
