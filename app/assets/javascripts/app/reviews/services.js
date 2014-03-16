'use strict';

/* Services */

fiApp.factory('ReviewsSrv', ['$resource', function($resource) {
  
  return $resource('/api/reviews/:id', { id: '@id' }, { 'update': { method: 'PUT' } });
}]);
