'use strict';

/* Services */

fiApp.factory('SessionSrv', ['$http', '$q', '$cacheFactory', function($http, $q, $cf) {
  
  var service = {
    data: null,
    
    isAuthenticated: function() {
      return !!this.data;
    },
    getUser: function() {
      var self = this;
      if (self.isAuthenticated()) {
        return $q.when(self.data);
      }
      else {
        return $http.get('/api/session', { cache: true }).then(function(resp) {
          return self.data = resp.data;
        });
      }
    },
    getAccount: function() {
      var self = this;
      if (self.isAuthenticated()) {
        return $q.when(self.data);
      }
      else {
        return $http.get('/api/session', { cache: true }).then(function(resp) {
          return self.data = resp.data;
        });
      }
    }
  };
  
  return service;
}]);
