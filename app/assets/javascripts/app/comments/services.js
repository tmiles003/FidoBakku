'use strict';

/* Services */

fiApp.factory('CommentsSrv', ['$resource', function($resource) {
  
  return $resource('/api/comments/:id', 
    { id: '@id' }, 
    { 'update': { method: 'PUT' } 
  });
}]);
