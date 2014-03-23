'use strict';

/* Services */

fiApp.factory('SessionSrv', ['$http', '$q', function($http, $q) {
  
  var data = null;
  
  var service = {
    
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
    },
    getData: function() {}
  };
  
  return service;
}]);
