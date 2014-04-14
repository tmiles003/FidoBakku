'use strict';

fiApp.config(['$routeProvider', '$locationProvider', 
              function($routeProvider, $locationProvider) {
  
  $routeProvider.when('/dashboard', { 
    templateUrl: '/templates/dashboard/index.html', 
    controller: 'DashboardCtrl' 
  });
  
  /* admin routes first */
  
  $routeProvider.when('/admin/staff', { 
    templateUrl: '/templates/admin/users/index.html', 
    controller: 'UsersAdminCtrl', 
    resolve: { 
      users: function(UsersAdminSrv) { 
        return UsersAdminSrv.query()['$promise']; 
      },
      teams: function(TeamsAdminSrv) {
        return TeamsAdminSrv.query()['$promise'];
      }
    }
  });
  
  $routeProvider.when('/admin/forms', { 
    templateUrl: '/templates/admin/forms/index.html', 
    controller: 'FormsAdminCtrl', 
    resolve: {
      forms: function(FormsAdminSrv) { 
        return FormsAdminSrv.query()['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/admin/form/:id/:slug', { 
    templateUrl: '/templates/admin/forms/manage.html', 
    controller: 'FormSectionsAdminCtrl',
    resolve: {
      form: function(FormsAdminSrv, $route) {
        return FormsAdminSrv.get({ id: $route.current.params.id })['$promise'];
      },
      sections: function(FormSectionsAdminSrv, $route) { 
        return FormSectionsAdminSrv.query({ form_id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  // list all the evaluation sessions
  $routeProvider.when('/admin/evaluations', { 
    templateUrl: '/templates/admin/evaluations/index.html', 
    controller: 'EvaluationSessionsAdminCtrl', 
    resolve: {
      sessions: function(EvaluationSessionsAdminSrv) { 
        return EvaluationSessionsAdminSrv.query()['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/admin/session/:id/:slug', { 
    templateUrl: '/templates/admin/evaluations/session.html', 
    controller: 'EvaluationsAdminCtrl', 
    resolve: {
      session: function(EvaluationSessionsAdminSrv, $route) {
        return EvaluationSessionsAdminSrv.get({ id: $route.current.params.id })['$promise'];
      },
      evaluations: function(EvaluationsAdminSrv, $route) { 
        return EvaluationsAdminSrv.query({ session_id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  // manage 1 evaluation (assign, etc)
  $routeProvider.when('/admin/evaluations/:id/:name', { 
    templateUrl: '/templates/admin/evaluations/user.html', 
    controller: 'UserEvaluationsAdminCtrl',
    resolve: {
      evaluation: function(EvaluationsAdminSrv, $route) {
        return EvaluationsAdminSrv.get({ id: $route.current.params.id })['$promise'];
      },
      userEvaluations: function(UserEvaluationsAdminSrv, $route) {
        return UserEvaluationsAdminSrv.query({ evaluation_id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  $routeProvider.when('/admin/account', { 
    templateUrl: '/templates/admin/account/index.html', 
    controller: 'AccountAdminCtrl',
    resolve: {
      account: function(AccountAdminSrv) {
        return AccountAdminSrv.get()['$promise'];
      }
    }
  });
  
  /* routes for everyone */
  $routeProvider.when('/user/:id/:name', { 
    templateUrl: '/templates/user/index.html', 
    controller: 'UserCtrl',
    resolve: {
      user: function(UsersSrv, $route) { 
        return UsersSrv.get({ id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  $routeProvider.when('/goals', { 
    templateUrl: '/templates/goals/index.html', 
    controller: 'GoalsCtrl', 
    resolve: {
      goals: function(GoalsSrv) { 
        return GoalsSrv.query({ limit: 3 })['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/goal/:id/:slug', { 
    templateUrl: '/templates/goal/index.html', 
    controller: 'GoalCtrl',
    resolve: {
      goal: function(GoalsSrv, $route) { 
        return GoalsSrv.get({ id: $route.current.params.id });
      }
    }
  });
  
  // user review
  $routeProvider.when('/evaluation/:id/:name', { 
    templateUrl: '/templates/evaluation/index.html', 
    controller: 'UserEvaluationCtrl',
    resolve: {
      userEvaluation: function(UserEvaluationSrv, $route) {
        return UserEvaluationSrv.get({ id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  // evaluation feedback
  $routeProvider.when('/feedback/:id/:name', { 
    templateUrl: '/templates/feedback/index.html', 
    controller: 'FeedbackCtrl',
    resolve: {
      feedback: function(FeedbackSrv, $route) {
        return FeedbackSrv.get({ id: $route.current.params.id })['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/profile', { 
    templateUrl: '/templates/profile/index.html', 
    controller: 'ProfileCtrl' 
  });
  
  $routeProvider.otherwise({ 
    redirectTo: '/dashboard' 
  });
  
}]);
