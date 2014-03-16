'use strict';

/* Services */

fiApp.factory('UserReviewsSrv', ['$resource', '$http', function($resource, $http) {
  
  return $resource('/api/user_reviews/:id', { id: '@id' }, { 'update': { method: 'PUT' } });
}]);
