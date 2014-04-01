'use strict';

/* Services */

fiApp.factory('UsersSrv', ['$resource', function($resource) {
  
  return $resource('/api/users/:id', { id: '@id' }, { 
    'update': { method: 'PUT' },
    'current': { url: '/api/users/current' },
    'getRoles': { method: 'GET', url: '/api/users/roles', cache: true, isArray: true }
  });
}]);

fiApp.factory('TeamsSrv', ['$resource', function($resource) {
  
  return $resource('/api/teams/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
