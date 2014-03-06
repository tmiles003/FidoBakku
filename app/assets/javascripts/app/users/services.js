'use strict';

/* Services */

var UserSrv = angular.module('fiUserService', []);

UserSrv.factory('User', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
