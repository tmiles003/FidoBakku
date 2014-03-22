'use strict';

/* Services */

fiApp.factory('AbilitiesSrv', ['$http', function($http) {
  
  var service = {
    get: function(section) {
      // console.log(section);
      return $http.get('/api/abilities.json');
    }
  }
  
  return service;
}]);
