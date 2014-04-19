class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    
    user ||= User.new # guest user (not logged in)
    
    if 'admin' == user.role
      can :manage, :all
    end
    
    if 'manager' == user.role
      #can :manage, :all
      can :show, Account
      can :read, Team
      can :manage, [Goal, EvaluationSession, Evaluation, UserEvaluation]
      can :manage, [Form, FormSection, FormComp, FormPart, FormUser]
      can :manage, Comment, :user_id => user.id # only user's own comments
    end
    
    if 'employee' == user.role
      #can :manage, :all
      can :read, Form, Team
      can [:read, :update], UserEvaluation, :evaluator_id => user.id
      can [:read, :update], Evaluation, :user_id => user.id
      can [:read, :update], Goal, :user_id => user.id
      can :manage, Comment, :user_id => user.id # only user's own comments
    end
    
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
