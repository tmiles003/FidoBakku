'use strict';

/* Services */

fiApp.factory('EvaluationsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/evaluations/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
