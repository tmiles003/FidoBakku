class Api::DashboardController < Api::ApiController
  
  def evaluations
    render nothing: true
    #render json: ::UserEvaluation.where(evaluator_id: current_user.id).includes(evaluation: :user), 
    #  each_serializer: Dashboard::UserEvaluationSerializer
  end
  
  def feedbacks
    render nothing: true
    #render json: ::Evaluation.all, each_serializer: Dashboard::EvaluationSerializer
  end
  
  def users
    render nothing: true
    #render json: current_user.account.users, each_serializer: Dashboard::UserSerializer
  end
  
end
