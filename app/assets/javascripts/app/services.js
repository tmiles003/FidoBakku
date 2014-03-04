'use strict';

/* Services */

angular.module('fbApp.services', [])
  
  .factory('UserService', ['$http', '$q', function($http, $q) {
    var service = {
      
      getUserList: function() {
        var d = $q.defer();
        
        return $http.post('/people/list.json')
          .success(function(data, status) {
            d.resolve(data.data);
          })
          .error(function(data, status) {
            d.reject(data);
          });
      }
      
    };
    
    return service;
  }])
;
