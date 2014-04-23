class Admin::Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress, :name, :email_hash #, user_evaluation_path
  
  def name
    object.evaluator.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.evaluator.email).hexdigest
  end
  
end
