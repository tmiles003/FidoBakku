'use strict';

/* Services */

fiApp.factory('TopicsSrv', ['$resource', function($resource) {
  
  return $resource('/api/topics/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/forms/:form_id/topics', params: { form_id: 'formId' }, isArray: true },
      'up': { method: 'POST', url: '/api/topics/:id/up' },
      'down': { method: 'POST', url: '/api/topics/:id/down' }
    });
}]);

fiApp.factory('BenchmarksSrv', ['$resource', function($resource) {
  
  return $resource('/api/benchmarks/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' }, 
      'query': { url: '/api/topics/:topic_id/benchmarks', params: { topic_id: 'topicId' }, isArray: true },
      'save': { method: 'POST', url: '/api/topics/:topic_id/benchmarks', params: { topic_id: '@topic_id' } },
      'up': { method: 'POST', url: '/api/benchmarks/:id/up' },
      'down': { method: 'POST', url: '/api/benchmarks/:id/down' }
    });
}]);
