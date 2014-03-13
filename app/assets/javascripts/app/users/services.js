'use strict';

/* Services */

fiApp.factory('UsersSrv', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' }, { 
  	'update': { method:'PUT' } 
  });
}]);
