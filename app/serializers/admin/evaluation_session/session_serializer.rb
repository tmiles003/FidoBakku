class Admin::EvaluationSession::SessionSerializer < ActiveModel::Serializer
  
  attributes :id, :title, :created_at, :manage_path, :teams, :users
  has_many :evaluations, serializer: ::Admin::EvaluationSession::EvaluationSerializer
  
  def created_at
    object.created_at.strftime('%s') unless object.created_at.nil?
  end
  
  def manage_path
    root_path(anchor: admin_session_manage_path(object))
  end
  
  def evaluations
    evaluations = ::Evaluation.where(evaluation_session_id: object.id).includes(:user)
  end
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = ::FormUser.in_account(scope.account.id)
      .includes(:form, user: :team)
      .where('form_users.form_id IS NOT NULL')
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Admin::Form::FormUserSerializer)
  end
  
end
