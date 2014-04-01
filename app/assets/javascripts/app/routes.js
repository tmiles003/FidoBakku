'use strict';

fiApp.config(['$routeProvider', '$locationProvider', 
              function($routeProvider, $locationProvider) {
  
  $routeProvider.when('/dashboard', { 
    templateUrl: '/templates/dashboard/index.html', 
    controller: 'DashboardCtrl' 
  });
  
  $routeProvider.when('/staff', { 
    templateUrl: '/templates/users/index.html', 
    controller: 'UsersCtrl', 
    resolve: { 
      users: function(UsersSrv) { 
        return UsersSrv.query()['$promise']; 
      },
      teams: function(TeamsSrv) {
        return TeamsSrv.query()['$promise'];
      }
    }
  });
  
  $routeProvider.when('/user/:id/:name', { 
    templateUrl: '/templates/user/index.html', 
    controller: 'UserCtrl',
    resolve: {
      user: function(UsersSrv, $route) { 
        return UsersSrv.get({ id: $route.current.params.id });
      },
      goals: function(GoalsSrv, $route) { 
        return GoalsSrv.query({ user_id: $route.current.params.id })['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/goals', { 
    templateUrl: '/templates/goals/index.html', 
    controller: 'GoalsCtrl', 
    resolve: { 
      user: function(UsersSrv) {
        return UsersSrv.current()['$promise'];
      },
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
  
  $routeProvider.when('/forms', { 
    templateUrl: '/templates/forms/index.html', 
    controller: 'FormsCtrl', 
    resolve: {
      forms: function(FormsSrv) { 
        return FormsSrv.query()['$promise']; 
      }
    }
  });
  
  $routeProvider.when('/form/:id/:slug', { 
    templateUrl: '/templates/forms/manage.html', 
    controller: 'TopicsCtrl',
    resolve: {
      topics: function(TopicsSrv, $route) { 
        return TopicsSrv.query({ form_id: $route.current.params.id });
      }
    }
  });
  
  // list all the reviews
  $routeProvider.when('/reviews', { 
    templateUrl: '/templates/reviews/index.html', 
    controller: 'ReviewsCtrl', 
    resolve: {
      reviews: function(ReviewsSrv) { 
        return ReviewsSrv.query()['$promise']; 
      }
    }
  });
  
  // single review
  $routeProvider.when('/reviews/:id/:slug', { 
    templateUrl: '/templates/reviews/manage.html', 
    controller: 'ReviewsManageCtrl',
    resolve: {
      userReviews: function(UserReviewsSrv, $route) {
        return UserReviewsSrv.query({ review_id: $route.current.params.id })['$promise'];
      }
    }
  });
  
  // user review
  $routeProvider.when('/review/:id/:name', { 
    templateUrl: '/templates/review/index.html', 
    controller: 'UserReviewsCtrl',
    resolve: {
      review: function(UserReviewsSrv, $route) {
        return UserReviewsSrv.get({ id: $route.current.params.id })['$promise']; 
      }
    }
  });
  
  // review feedback
  $routeProvider.when('/feedback/:id/:name', { 
    templateUrl: '/templates/feedback/index.html', 
    controller: 'FeedbackCtrl'
    // , resolve: {}
  });
  
  $routeProvider.when('/account', { 
    templateUrl: '/templates/account/index.html', 
    controller: 'AccountCtrl',
    resolve: {
      account: function(AccountSrv) {
        return AccountSrv.get()['$promise'];
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
