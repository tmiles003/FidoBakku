'use strict';

/* Services */

fiApp.factory('UserSrv', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' }, { 
  	'update': { method:'PUT' } 
  });
}]);
