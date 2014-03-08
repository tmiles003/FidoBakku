'use strict';

/* Services */

var FormSectionSrv = angular.module('fiFormSectionService', []);

FormSectionSrv.factory('FormSection', ['$resource', function($resource) {
  
  return $resource('/api/forms/:form_id/form_sections/:id', 
    { form_id: '@form_id', id: '@id' }, { 'update': { method: 'PUT' } });
}]);
