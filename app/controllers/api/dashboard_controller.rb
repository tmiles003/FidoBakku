class Api::DashboardController < Api::ApiController
  
  def evaluations
    # optimise those queries a bit more
    render json: ::UserEvaluation.where(evaluator_id: @user.id), 
      each_serializer: Dashboard::UserEvaluationSerializer
  end
  
  def feedbacks
    render json: ::Evaluation.all, each_serializer: Dashboard::EvaluationSerializer
  end
  
end
