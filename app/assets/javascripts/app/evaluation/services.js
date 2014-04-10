'use strict';

/* Services */

fiApp.factory('UserEvaluationSrv', ['$resource', '$http', function($resource, $http) {
  
  return $resource('/api/user_evals/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);
