'use strict';

/* Services */

fiApp.factory('DashboardSrv', ['$resource', function($resource) {
  
  return $resource('/api/dashboard', {}, {
    'query': { isArray: false } 
  });
}]);
