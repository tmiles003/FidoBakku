'use strict';

/* Services */

fiApp.factory('UsersSrv', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' }, { 
    'update': { method: 'PUT' },
    'getRoles': { method: 'GET', url: '/api/users/roles', cache: true, isArray: true }
  });
}]);
