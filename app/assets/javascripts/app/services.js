'use strict';

/* Services */

angular.module('fbApp.services', [])
  
  .factory('UserService', function($http, $q) {
    var service = {
      
      getUserList: function() {
        var d = $q.defer();
        $http.post('/people/list.json')
          .then(function(data, status) {
            if (data.status === 200)
              d.resolve(data);
            else
              d.reject(data);
          });
        
        return d.promise;
      }
      
    };
    
    return service;
  })
;
