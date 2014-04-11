'use strict';

/* Services */

fiApp.factory('FormsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/forms/:id', { id: '@id' }, { 
    'update': { method:'PUT' }
  });
}]);
