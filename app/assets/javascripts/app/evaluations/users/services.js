'use strict';

/* Services */

fiApp.factory('UserEvaluationsSrv', ['$resource', function($resource) {
  
  return $resource('/api/user_evals/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
