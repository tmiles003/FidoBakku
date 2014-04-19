'use strict';

/* Services */

fiApp.factory('CurrentUserSrv', ['$http', '$q', '$rootScope', function($http, $q, $rootScope) {
  
  var service = {
    
    currentUser: null,
    
    getUser: function() {
      if (!!service.currentUser) {
        return $q.when(service.currentUser);
      }
      else {
        return $http.get('/api/current_user').then(function(resp) {
          return service.currentUser = resp.data;
        });
      }
    },
    
    setUser: function(user) {
      service.currentUser = user;
      $rootScope.$broadcast('updateCurrUser');
    }
    
  };
    
  return service;
}]);

fiApp.factory('NotifSrv', ['toaster', function(toaster) {
  
  var service = {
    
    success: function(title, text, timeout) {
      timeout = timeout || 500;
      toaster.pop('success', title, text, timeout);
    },
    
    info: function(title, text, timeout) {
      timeout = timeout || 10000;
      toaster.pop('info', title, text, timeout);
    },
    
    error: function(title, text, timeout) {
      timeout = timeout || 10000;
      toaster.pop('error', title, text, timeout);
    }
    
  };
  
  return service;
}]);
