'use strict';

/* Controllers */

fiApp.controller('AccountCtrl', ['$scope', 'AccountSrv', 'SessionSrv', function($scope, Account, Session) {
  
  Session.getAccount().then(function(re) {
    $scope.account = re.account;
  });
  Session.getUser().then(function(re) {
    $scope.user = re.user;
  });
  
}]);
