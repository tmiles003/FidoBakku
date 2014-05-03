class DashboardSerializer < ActiveModel::Serializer
  
  attributes :teams, :users, :user_evaluations, :evaluations
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = scope.account.users.includes(:team)
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Dashboard::UserSerializer)
  end
  
  def user_evaluations
    user_evaluations = UserEvaluation.where(account_id: current_user.account.id) # can't use scope because of ambiguity
      .where(evaluator_id: current_user.id)
      .includes(:comment, evaluation: :user)
      .where('evaluations.mode = ?', 'evaluations').references(:evaluations)
    ActiveModel::ArraySerializer.new(user_evaluations, each_serializer: ::Dashboard::UserEvaluationSerializer)
  end
  
  def evaluations
    evaluations = Evaluation.where(account_id: current_user.account.id) # same as above
      .where('evaluations.mode = ?', 'feedback')
      .includes(:user)
    ActiveModel::ArraySerializer.new(evaluations, each_serializer: ::Dashboard::EvaluationSerializer)
  end
  
end
