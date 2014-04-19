class AbilityAdmin
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here
    
    user ||= User.new # guest user (not logged in)
    
    if 'admin' == user.role
      can :manage, :all
    end
    
    if 'manager' == user.role
      #can :manage, :all
      can :show, Account
      can :read, [User, Team]
      can :manage, [Goal, EvaluationSession, Evaluation, UserEvaluation]
      can :manage, [Form, FormSection, FormComp, FormPart, FormUser]
    end
    
    if 'employee' == user.role
    end
    
  end
end
