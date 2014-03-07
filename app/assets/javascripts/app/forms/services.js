'use strict';

/* Services */

var FormSrv = angular.module('fiFormService', []);

FormSrv.factory('Form', ['$resource', function($resource) {
  
  return $resource('/api/forms/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
