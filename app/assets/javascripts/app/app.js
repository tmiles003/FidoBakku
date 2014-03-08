'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  
  'fiUserService',
  'fiUserController',
  
  'fiFormService',
  'fiFormController'
]);

/* fiApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider
    .when('/people', 
      { templateUrl: '/partials/users/index.html', controller: 'UserCtrl' })
    .when('/forms', 
      { templateUrl: '/templates/forms/index.html', controller: 'FormCtrl' });
}]); */
