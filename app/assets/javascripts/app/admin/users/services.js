'use strict';

/* Services */

fiApp.factory('UsersAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/users/:id', { id: '@id' }, { 
    'update': { method: 'PUT' },
    'current': { url: '/api/admin/users/current' }, // move this to !/admin
    'getRoles': { method: 'GET', url: '/api/admin/users/roles', cache: true, isArray: true }
  });
}]);

fiApp.factory('TeamsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/teams/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
