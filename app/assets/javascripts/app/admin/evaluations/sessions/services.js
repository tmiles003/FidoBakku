'use strict';

/* Services */

fiApp.factory('EvaluationSessionsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/evaluation_sessions/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
