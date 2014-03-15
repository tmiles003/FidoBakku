'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource'
]);

fiApp.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  // $locationProvider.html5Mode(true); // nice urls.
  
  $routeProvider.when('/dashboard', 
    { templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl' });
  $routeProvider.when('/people', 
    { templateUrl: '/templates/users/index.html', controller: 'UsersCtrl' });
  $routeProvider.when('/forms', 
    { templateUrl: '/templates/forms/index.html', controller: 'FormsCtrl' });
  $routeProvider.when('/form/:id/:slug', 
    { templateUrl: '/templates/forms/manage.html', controller: 'TopicsCtrl' });
  // list all the reviews
  $routeProvider.when('/reviews', 
    { templateUrl: '/templates/reviews/index.html', controller: 'ReviewsCtrl' });
  // review
  $routeProvider.when('/reviews/:id/:slug', 
    { templateUrl: '/templates/reviews/manage.html', controller: 'UserReviewsCtrl' });
  
  // user review
  $routeProvider.when('/review/:id/:name', 
    { templateUrl: '/templates/review/index.html', controller: 'ReviewCtrl' });
  
  $routeProvider.when('/account', 
    { templateUrl: '/templates/account/index.html', controller: 'AccountCtrl' });
  $routeProvider.when('/profile', 
    { templateUrl: '/templates/profile/index.html', controller: 'ProfileCtrl' });
  
  $routeProvider.otherwise({ redirectTo: '/dashboard' });
}]);
