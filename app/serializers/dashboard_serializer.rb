class DashboardSerializer < ActiveModel::Serializer
  
  def attributes
    hash = super
        
    hash['user'] = Dashboard::UserSerializer.new(object, :root => false)
    hash['goals'] = goals
    hash['evaluations'] = evaluations
    hash['user_evaluations'] = user_evaluations
    
    if 'admin' == object.role || 'manager' == object.role
      hash['teams'] = teams
      hash['users'] = users
      hash['feedbacks'] = feedbacks
    end
    
    hash
  end
  
  def teams
    teams = scope.account.teams
    ActiveModel::ArraySerializer.new(teams, each_serializer: ::Admin::TeamSerializer)
  end
  
  def users
    users = scope.account.users.includes(:team)
    ActiveModel::ArraySerializer.new(users, each_serializer: ::Dashboard::UserSerializer)
  end
  
  def goals
    []
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
      .where(user_id: current_user.id)
      .where('evaluations.done = ?', true)
      .includes(:user)
    ActiveModel::ArraySerializer.new(evaluations, each_serializer: ::Dashboard::EvaluationSerializer)
  end
  
  def feedbacks
    evaluations = Evaluation.where(account_id: current_user.account.id) # same as above
      .where('evaluations.mode = ?', 'feedback')
      .includes(:user)
    ActiveModel::ArraySerializer.new(evaluations, each_serializer: ::Dashboard::EvaluationSerializer)
  end
  
end
