class User::UserSerializer < BaseUserSerializer
  
  attributes :id, :name, :email_hash
  has_one :team, serializer: ::User::TeamSerializer
  has_many :goals, serializer: ::User::GoalSerializer
  has_many :evaluations, serializer: ::User::EvaluationSerializer
  
end
