'use strict';

/* Services */

fiApp.factory('AccountAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/account', {}, { 'update': { method:'PUT' } });
}]);
