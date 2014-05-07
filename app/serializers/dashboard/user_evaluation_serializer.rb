class Dashboard::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :name, :email_hash, :team_id, :progress, :comment, :evaluation_path
  
  def name
    object.evaluation.user.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.evaluation.user.email).hexdigest
  end
  
  def team_id
    object.evaluation.user.team.id unless object.evaluation.user.team.nil?
  end
  
  def progress
    # 180 / 3.6 = 50 (since we need 100%)
    sprintf('%.2e', object.progress * Math::PI / 50).to_f
  end
  
  def comment
    unless object.comment.nil?
      unless object.comment.content.nil?
        !object.comment.content.empty?
      end
    end
  end
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
