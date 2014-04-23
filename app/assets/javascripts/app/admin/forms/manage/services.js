'use strict';

/* Services */

fiApp.factory('FormSectionsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_sections/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'up': { method: 'PUT', url: '/api/admin/form_sections/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/admin/form_sections/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormCompsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_comps/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' },
      'up': { method: 'PUT', url: '/api/admin/form_comps/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/admin/form_comps/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormPartAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_parts/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }
    });
}]);
