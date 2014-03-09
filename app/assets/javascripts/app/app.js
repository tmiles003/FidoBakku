'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  
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

/* fiApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/people', 
      { templateUrl: '/partials/users/index.html', controller: 'UserCtrl' });
  $routeProvider.when('/forms', 
      { templateUrl: '/templates/forms/index.html', controller: 'FormCtrl' });
  $routeProvider.when('/forms/:id/:slug', 
      { templateUrl: '/templates/forms/edit.html', controller: 'FormSectionCtrl' });
}]); */
