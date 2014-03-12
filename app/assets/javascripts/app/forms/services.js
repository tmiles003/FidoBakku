'use strict';

/* Services */

fiApp.factory('FormSrv', ['$resource', function($resource) {
  
  return $resource('/api/forms/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
