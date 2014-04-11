'use strict';

/* Services */

fiApp.factory('FeedbackSrv', ['$resource', function($resource) {
  
  return $resource('/api/feedback/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);
