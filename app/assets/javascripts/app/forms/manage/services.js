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

fiApp.factory('CompsSrv', ['$resource', function($resource) {
  
  return $resource('/api/comps/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/sections/:section_id/comps', params: { section_id: 'sectionId' }, isArray: true },
      'save': { method: 'POST', url: '/api/sections/:section_id/comps', params: { section_id: '@section_id' } },
      'up': { method: 'PUT', url: '/api/comps/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/comps/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormPartSrv', ['$resource', function($resource) {
  
  return $resource('/api/form_parts/:id', 
    { id: '@id' }, 
    { 'query': { isArray: false },
      'update': { method: 'PUT' }
    });
}]);

fiApp.factory('FormUserSrv', ['$resource', function($resource) {
  
  return $resource('/api/forms/:id', 
    { id: '@id', user_id: '@userId' }, 
    { 'users': { url: '/api/forms/:id/users', isArray: true },
      'assign': { method: 'PUT', url: '/api/forms/:id/assign/:user_id' }
    });
}]);
