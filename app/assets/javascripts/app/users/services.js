'use strict';

/* Services */

// var fiAppSrv = angular.module('fiApp.services');

fiApp.factory('UserService', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' });
}]);
