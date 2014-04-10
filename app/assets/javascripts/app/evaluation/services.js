'use strict';

/* Services */

fiApp.factory('UserEvaluationSrv', ['$resource', function($resource) {
  
  return $resource('/api/user_evaluation/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);
