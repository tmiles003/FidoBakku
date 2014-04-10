class UserEvaluationSerializer < ActiveModel::Serializer
  attributes :id, :user, :form_ids, :progress, :scores
  
  def user
    user = ::User.select('name, MD5(email) AS email_hash').find(object.user_id)
    # user.delete('id')
    # user = Hash.new(name: u.name, email_hash: OpenSSL::Digest::MD5.new(u.email).hexdigest)
  end
  
  def form_ids
    ::FormPart.get_parts object.form_id
  end
  
end
