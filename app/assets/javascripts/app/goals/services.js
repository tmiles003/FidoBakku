'use strict';

/* Services */

fiApp.factory('GoalsSrv', ['$resource', function($resource) {
  
  return $resource('/api/goals/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }
  });
}]);
