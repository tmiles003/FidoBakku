'use strict';

/* Services */

fiApp.factory('ReviewSrv', ['$resource', '$http', function($resource, $http) {
  
  // return $resource('/api/reviews/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
