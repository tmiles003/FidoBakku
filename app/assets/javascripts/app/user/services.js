'use strict';

/* Services */

fiApp.factory('UserSrv', ['$resource', '$http', function($resource, $http) {
  
  var service = {
    getReview: function(userId) {
      return $http.get('/api/review/'+ userId);
    }
  }
  
  return service;
}]);
