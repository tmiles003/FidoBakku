'use strict';

/* Services */

var ReviewSrv = angular.module('fiReviewService', []);

ReviewSrv.factory('Review', ['$resource', function($resource) {
  
  return $resource('/api/reviews/:id', { id: '@id' }, { 'update': { method:'PUT' } });
}]);
