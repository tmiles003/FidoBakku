'use strict';

/* Services */

fiApp.factory('FormsSrv', ['$resource', function($resource) {
  
  return $resource('/api/forms/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
