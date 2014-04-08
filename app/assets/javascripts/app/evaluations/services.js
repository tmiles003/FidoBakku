'use strict';

/* Services */

fiApp.factory('EvaluationSessionsSrv', ['$resource', function($resource) {
  
  return $resource('/api/evaluation_sessions/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
