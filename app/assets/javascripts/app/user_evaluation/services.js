'use strict';

/* Services */

fiApp.factory('UserEvaluationSrv', ['$resource', function($resource) {
  
  return $resource('/api/user_evaluation/:id', { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);

fiApp.factory('FormCompSrv', ['$resource', function($resource) {
  
  return $resource('/api/form_comp/:id', { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);
