'use strict';

/* Services */

fiApp.factory('AccountSrv', ['$resource', function($resource) {
  
  return $resource('/api/account', {}, { 'update': { method:'PUT' } });
}]);
