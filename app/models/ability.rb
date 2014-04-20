class Ability
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
      can [:create, :read], [Form, Team]
      
      # update own stuff, except for goals,
      # but can see other people's stuff [kinda, need url for it]
      can [:manage], UserEvaluation, :evaluator_id => user.id
      can [:manage], Evaluation, :user_id => user.id
      can [:create, :read, :destroy], [UserEvaluation, Evaluation]
      can [:manage], Goal
      
      can :manage, Comment, :user_id => user.id # only user's own comments
    end
    
    if 'employee' == user.role
      #can :manage, :all
      can :read, [Form, Team]
      can [:read, :update], UserEvaluation, :evaluator_id => user.id
      can [:read, :update], Evaluation, :user_id => user.id
      can [:read, :update], Goal, :user_id => user.id
      can :manage, Comment, :user_id => user.id # only user's own comments
    end
    
  end
end
