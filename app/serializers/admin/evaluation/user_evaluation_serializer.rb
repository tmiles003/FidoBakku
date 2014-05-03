class Admin::Evaluation::UserEvaluationSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :email_hash, :progress, :comment
  
  def name
    object.evaluator.name
  end
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.evaluator.email).hexdigest
  end
  
  def progress
    sprintf('%.2e', object.progress * Math::PI / 50).to_f
  end
  
  def comment
    unless object.comment.nil?
      unless object.comment.content.nil?
        !object.comment.content.empty?
      end
    end
  end
  
end
