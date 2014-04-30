'use strict';

/* Services */

fiApp.factory('EvaluationLoopsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/evaluation_loops/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
