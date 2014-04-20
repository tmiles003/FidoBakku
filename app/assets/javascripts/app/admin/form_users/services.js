'use strict';

/* Services */

fiApp.factory('FormUserAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_users/:id', { id: '@id' }, { 
      'update': { method: 'PUT' }
    });
}]);
