'use strict';

/* Controllers */

fiApp.controller('AccountCtrl', ['$scope', 'AccountSrv', function($scope, Account) {
  
  $scope.account = { name: '' }; // Account.getAccount();
  $scope.user = { name: '' }; // Account.getUser();
  
}]);
