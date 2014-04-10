class Api::DashboardController < Api::ApiController
  
  def evaluations
    # optimise those queries a bit more
    render json: ::UserEvaluation.where(evaluator_id: @user.id), 
      each_serializer: UserEvaluationDashboardSerializer
  end
  
end
