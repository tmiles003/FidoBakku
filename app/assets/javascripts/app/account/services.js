'use strict';

/* Services */

fiApp.factory('AccountSrv', ['$cacheFactory', '$http', function($cf, $http) {
  
  var accountCache = $cf('accountCache');  
  var data = {};
  
  return {
    getAccount: function() {
      return '';
    },
    getUser: function() {
      return '';
    }
  }
}]);
