'use strict';

/* Services */

fiApp.factory('UserEvaluationsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/user_evaluations/:id', { id: '@id' }, { 
    'update': { method: 'PUT' }
  });
}]);
