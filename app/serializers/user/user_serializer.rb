class User::UserSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :email_hash
  has_one :team, serializer: ::User::TeamSerializer
  has_many :goals, serializer: ::User::GoalSerializer
  has_many :evaluations, serializer: ::User::EvaluationSerializer
  
  def email_hash
    OpenSSL::Digest::MD5.new(object.email).hexdigest
  end
  
end
