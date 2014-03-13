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
  $routeProvider.when('/reviews', 
    { templateUrl: '/templates/reviews/index.html', controller: 'ReviewsCtrl' });
  $routeProvider.when('/review/:id/:slug', 
    { templateUrl: '/templates/reviews/manage.html', controller: 'UserReviewsCtrl' });
  
  /* $routeProvider.when('/user', 
    { templateUrl: '/templates/user/index.html', controller: 'UserCtrl' }); */
  
  $routeProvider.when('/account', 
    { templateUrl: '/templates/account/index.html', controller: 'AccountCtrl' });
  $routeProvider.when('/profile', 
    { templateUrl: '/templates/profile/index.html', controller: 'ProfileCtrl' });
  
  $routeProvider.otherwise({ redirectTo: '/dashboard' });
}]);
