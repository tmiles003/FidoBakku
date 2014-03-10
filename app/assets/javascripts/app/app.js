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
  'fiFormSectionService',
  'fiFormSectionController',
  'fiSectionBenchmarkService',
  'fiSectionBenchmarkController',
  
  'fiReviewService',
  'fiReviewController'
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
    { templateUrl: '/templates/forms/edit.html', controller: 'FormSectionCtrl' });
  $routeProvider.otherwise({ redirectTo: '/dashboard' });
}]);
