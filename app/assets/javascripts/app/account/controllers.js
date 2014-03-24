'use strict';

/* Controllers */

fiApp.controller('AccountCtrl', ['$scope', 'AccountSrv', 'NotifSrv', '$http', 'account',
                  function($scope, AccountSrv, NotifSrv, $http, account) {
  
  $scope.account = account;
  $scope.admins = [];
  $http.get('/api/users/list?role[]=admin').success(function(list) { 
    $scope.admins = list;
  });
  
  var updateAccount = function(account) {
    account.$update(function(val, resp) {
      $scope.account = val;
      NotifSrv.success();
      // refresh session details
    });
  }
  
  $scope.saveAccount = function(account, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      updateAccount(account);
    }
  }
  
  /* $scope.deleteAccount = function(account) {
    account.$delete(function() {
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  } */
  
}]);
