'use strict';

var fiApp = angular.module('fiApp', [
  'ngRoute',
  'ngResource',
  'ui.bootstrap', 'ui-bootstrap-tpls',
  'toaster'
]);

fiApp.config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push(function($q, $location, $timeout, $window, NotifSrv) {
    return {
      responseError: function(rejection) {
        if (403 == rejection.status) {
          NotifSrv.info('Unauthorised', null, 3000);
          $location.path('/');
        }
        // api errors when saving objects
        else if (422 == rejection.status || 404 == rejection.status) {
          _.each(rejection.data, function(err) {
            NotifSrv.error(_.first(err));
          });
        }
        else if (401 == rejection.status) {
          NotifSrv.info('Please sign in');
          $timeout(function() {
            $window.location.href = '/sign_in';
          }, 3500);
        }
        // upgrade
        else if (402 == rejection.status) {
          NotifSrv.info(rejection.data);
        }
        else if (500 == rejection.status) {
          NotifSrv.error('Sorry, something went wrong');
        }
        return $q.reject(rejection);
      }
    };
  });
}]);
