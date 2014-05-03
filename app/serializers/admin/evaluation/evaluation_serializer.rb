class Admin::Evaluation::EvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :form, :teams, :users, :evaluation_loop_path
  has_one :user, serializer: BaseUserSerializer
  has_many :user_evaluations, serializer: ::Admin::Evaluation::UserEvaluationSerializer
  
  def form
    object.form.name unless object.form.nil?
  end
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = ::User.in_account(scope.account.id).includes(:team)
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Admin::Evaluation::UserSerializer)
  end
  
  def evaluation_loop_path
    root_path(anchor: admin_loop_manage_path(object.evaluation_loop))
  end
  
  def user_evaluations
    user_evaluations = ::UserEvaluation.where(evaluation_id: object.id).includes(:evaluator, :comment)
  end
  
  # , :due_date, :due_date_ts
  
  def due_date
    object.due_date.strftime('%e %B %Y').strip unless object.due_date.nil?
  end
  
  def due_date_ts
    object.due_date.strftime('%s') unless object.due_date.nil?
  end
  
end
