'use strict';

/* Services */

fiApp.factory('FormSectionsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_sections/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/admin/forms/:form_id/form_sections', params: { form_id: 'formId' }, isArray: true },
      'up': { method: 'PUT', url: '/api/admin/form_sections/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/admin/form_sections/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormCompsAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_comps/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/admin/form_sections/:section_id/form_comps', params: { section_id: 'sectionId' }, isArray: true },
      'save': { method: 'POST', url: '/api/admin/form_sections/:section_id/form_comps', params: { section_id: '@section_id' } },
      'up': { method: 'PUT', url: '/api/admin/form_comps/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/admin/form_comps/:id/down', isArray: true }
    });
}]);

fiApp.factory('FormPartAdminSrv', ['$resource', function($resource) {
  
  return $resource('/api/admin/form_parts/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }
    });
}]);
