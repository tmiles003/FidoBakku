'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  
  'fiDashboardService',
  'fiDashboardController',
  
  'fiUserService',
  'fiUserController',
  
  'fiFormService',
  'fiFormController',
  'fiFormManageService',
  'fiFormManageController',
  
  'fiReviewService',
  'fiReviewController',
  // 'fiReviewManageService',
  // 'fiReviewManageController'
]);

fiApp.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  // $locationProvider.html5Mode(true); // nice urls.
  
  $routeProvider.when('/dashboard', 
    { templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl' });
  $routeProvider.when('/people', 
    { templateUrl: '/templates/users/index.html', controller: 'UserCtrl' });
  $routeProvider.when('/forms', 
    { templateUrl: '/templates/forms/index.html', controller: 'FormCtrl' });
  $routeProvider.when('/form/:id/:slug', 
    { templateUrl: '/templates/forms/manage.html', controller: 'TopicCtrl' });
  $routeProvider.when('/reviews', 
    { templateUrl: '/templates/reviews/index.html', controller: 'ReviewCtrl' });
  $routeProvider.when('/review/:id/:slug', 
    { templateUrl: '/templates/reviews/manage.html', controller: 'ReviewManageCtrl' });
  $routeProvider.otherwise({ redirectTo: '/dashboard' });
}]);
