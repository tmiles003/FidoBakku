class Dashboard::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :name, :email_hash, :progress, :evaluation_path
  
  def name
    object.evaluation.user.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.evaluation.user.email).hexdigest
  end
  
  def evaluation_path
    root_path(anchor: user_evaluation_path(object))
  end
  
end
