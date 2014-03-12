'use strict';

/* Services */

fiApp.factory('ReviewSrv', ['$resource', function($resource) {
  
  return $resource('/api/reviews/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
