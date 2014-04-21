'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  'ui.bootstrap', 'ui-bootstrap-tpls',
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
        // api errors when saving objects
        else if (422 == rejection.status) {
          _.each(rejection.data, function(err) {
            NotifSrv.error(_.first(err));
          });
        }
        else if (401 == rejection.status) {
          NotifSrv.info('Please log in');
        }
        // upgrade
        else if (402 == rejection.status) {
          NotifSrv.info(rejection.data);
        }
        return $q.reject(rejection);
      }
    };
  });
}]);
