'use strict';

/* Services */

var SectionBenchmarkSrv = angular.module('fiSectionBenchmarkService', []);

SectionBenchmarkSrv.factory('SectionBenchmark', ['$resource', function($resource) {
  
  return $resource('/api/forms/:form_id/sections/:section_id/benchmarks/:id', 
    { form_id: '@form_id', section_id: '@section_id', id: '@id' }, { 'update': { method: 'PUT' } });
}]);
