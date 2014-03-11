'use strict';

/* Services */

var ReviewManageSrv = angular.module('fiReviewManageService', []);

ReviewManageSrv.factory('UserReview', ['$resource', function($resource) {
  
  return $resource('/api/user_reviews/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
