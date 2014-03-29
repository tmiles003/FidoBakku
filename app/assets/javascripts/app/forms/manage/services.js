'use strict';

/* Services */

fiApp.factory('TopicsSrv', ['$resource', function($resource) {
  
  return $resource('/api/topics/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/forms/:form_id/topics', params: { form_id: 'formId' }, isArray: true },
      'up': { method: 'PUT', url: '/api/topics/:id/up', isArray: true },
      'down': { method: 'PUT', url: '/api/topics/:id/down', isArray: true }
    });
}]);

fiApp.factory('BenchmarksSrv', ['$resource', function($resource) {
  
  return $resource('/api/benchmarks/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/topics/:topic_id/benchmarks', params: { topic_id: 'topicId' }, isArray: true },
      'save': { method: 'POST', url: '/api/topics/:topic_id/benchmarks', params: { topic_id: '@topic_id' } },
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
