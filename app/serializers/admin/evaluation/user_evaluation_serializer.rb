class Admin::Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :progress, :name, :email_hash #, user_evaluation_path
  
  def progress
    sprintf('%.2e', object.progress * Math::PI / 50).to_f
  end
  
  def name
    object.evaluator.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.evaluator.email).hexdigest
  end
  
end
