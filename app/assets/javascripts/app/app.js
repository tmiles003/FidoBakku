'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  'toaster'
]);

fiApp.config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push(function($q, $location, NotifSrv) {
    return {
      responseError: function(rejection) {
        if (403 == rejection.status) {
          NotifSrv.info('Unauthorised', null, 3000);
          $location.path('/');
        }
        if (401 == rejection.status) {
          NotifSrv.info('Please log in');
        }
        return $q.reject(rejection);
      }
    };
  });
}]);

fiApp.config(['$routeProvider', '$locationProvider', // '$routeParams', 
              function($routeProvider, $locationProvider) {
  // $locationProvider.html5Mode(true); // nice urls.
  
  $routeProvider.when('/dashboard', 
    { templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl' });
  $routeProvider.when('/staff', 
    { templateUrl: '/templates/users/index.html', controller: 'UsersCtrl', 
      resolve: { 
        // abilities: function(AbilitiesSrv) { return ...; },
        users: function(UsersSrv) { return UsersSrv.query()['$promise']; } 
      }
  });
  $routeProvider.when('/forms', 
    { templateUrl: '/templates/forms/index.html', controller: 'FormsCtrl', 
      resolve: {
        forms: function(FormsSrv) { return FormsSrv.query()['$promise']; }
      }
  });
  $routeProvider.when('/form/:id/:slug', 
    { templateUrl: '/templates/forms/manage.html', controller: 'TopicsCtrl' });
  // list all the reviews
  $routeProvider.when('/reviews', 
    { templateUrl: '/templates/reviews/index.html', controller: 'ReviewsCtrl', 
      resolve: {
        reviews: function(ReviewsSrv) { return ReviewsSrv.query()['$promise']; }
      }
  });
  // single review
  $routeProvider.when('/reviews/:id/:slug', 
    { templateUrl: '/templates/reviews/manage.html', controller: 'ReviewsManageCtrl',
      resolve: {
        userReviews: function(UserReviewsSrv, $route) {
          return UserReviewsSrv.query({ review_id: $route.current.params.id })['$promise'];
        }
    }
  });
  
  // user review
  $routeProvider.when('/review/:id/:name', 
    { templateUrl: '/templates/review/index.html', controller: 'UserReviewsCtrl',
      resolve: {
        review: function(UserReviewsSrv, $route) {
          return UserReviewsSrv.get({ id: $route.current.params.id })['$promise'];
        }
      }
  });
  
  // review feedback
  
  $routeProvider.when('/account', 
    { templateUrl: '/templates/account/index.html', controller: 'AccountCtrl' });
  $routeProvider.when('/profile', 
    { templateUrl: '/templates/profile/index.html', controller: 'ProfileCtrl' });
  
  $routeProvider.otherwise({ redirectTo: '/dashboard' });
}]);
