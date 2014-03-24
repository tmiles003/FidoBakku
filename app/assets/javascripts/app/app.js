'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  'toaster'
]);

fiApp.config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push(function($q, $location, NotifSrv) {
    return {
      responseError: function(rejection) {
        if (403 == rejection.status) {
          NotifSrv.info('Unauthorised', null, 3000);
          $location.path('/');
        }
        else if (401 == rejection.status) {
          NotifSrv.info('Please log in');
        }
        else if (402 == rejection.status) {
          NotifSrv.info(rejection.data);
        }
        return $q.reject(rejection);
      }
    };
  });
}]);
