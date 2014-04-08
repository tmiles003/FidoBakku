'use strict';

/* Services */

fiApp.factory('EvaluationSessionsSrv', ['$resource', function($resource) {
  
  return $resource('/api/eval_sessions/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
