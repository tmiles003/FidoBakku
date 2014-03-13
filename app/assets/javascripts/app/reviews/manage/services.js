'use strict';

/* Services */

fiApp.factory('UserReviewsSrv', ['$resource', function($resource) {
  
  return $resource('/api/user_reviews/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
