'use strict';

/* Services */

fiApp.factory('GoalSrv', ['$resource', function($resource) {
  
  return $resource('/api/goals/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }
  });
}]);
