'use strict';

/* Services */

fbApp.factory('UserService', ['$http', '$q', '$rootScope', function($http, $q, $rootScope) {
  
  var service = {
    
    getUserList: function() {
      var d = $q.defer();
      
      return $http.post('/people/list.json', {})
        .success(function(data, status) {
          d.resolve(data.data);
        })
        .error(function(data, status) {
          d.reject(data);
        });
    },
    
    createUser: function(formData) {
      var d = $q.defer();
      
      return $http.post('/people.json', { data: formData })
        .success(function(data, status) {
          $rootScope.$broadcast('users.update');
          d.resolve('');
        })
        .error(function(data, status) {
          d.reject(data);
        });
    }
    
  };
  
  return service;
}]);
