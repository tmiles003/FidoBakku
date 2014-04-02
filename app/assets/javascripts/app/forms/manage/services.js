'use strict';

/* Services */

fiApp.factory('SectionsSrv', ['$resource', function($resource) {
  
  return $resource('/api/sections/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/forms/:form_id/sections', params: { form_id: 'formId' }, isArray: true },
      'up': { method: 'PUT', url: '/api/sections/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/sections/:id/down', isArray: true }
    });
}]);

fiApp.factory('BenchmarksSrv', ['$resource', function($resource) {
  
  return $resource('/api/benchmarks/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/sections/:section_id/benchmarks', params: { section_id: 'sectionId' }, isArray: true },
      'save': { method: 'POST', url: '/api/sections/:section_id/benchmarks', params: { section_id: '@section_id' } },
      'up': { method: 'PUT', url: '/api/benchmarks/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/benchmarks/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormUserSrv', ['$resource', function($resource) {
  
  return $resource('/api/forms/:id/user/:user_id', 
    { id: '@id', user_id: '@userId' }, 
    { 
      'update': { method: 'PUT' }
    });
}]);
