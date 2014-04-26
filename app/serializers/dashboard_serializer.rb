class DashboardSerializer < ActiveModel::Serializer
  
  attributes :teams, :users, :evaluations, :feedbacks
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = scope.account.users.includes(:team)
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Dashboard::UserSerializer)
  end
  
  def evaluations
    evaluations = UserEvaluation.where(evaluator_id: current_user.id)
      .includes(evaluation: :user)
      .where('evaluations.mode = ?', 'evaluations').references(:evaluations)
      #.joins(evaluation: :user).where('evaluations.mode = ?', 'evaluations')
    ActiveModel::ArraySerializer.new(evaluations, each_serializer: ::Dashboard::UserEvaluationSerializer)
  end
  
  def feedbacks
    feedbacks = Evaluation.where('evaluations.mode = ?', 'feedback')
      .includes(:user)
    ActiveModel::ArraySerializer.new(feedbacks, each_serializer: ::Dashboard::EvaluationSerializer)
  end
  
end
