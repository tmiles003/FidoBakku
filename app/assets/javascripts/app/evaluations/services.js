'use strict';

/* Services */

fiApp.factory('EvaluationsSrv', ['$resource', function($resource) {
  
  return $resource('/api/evaluations/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
