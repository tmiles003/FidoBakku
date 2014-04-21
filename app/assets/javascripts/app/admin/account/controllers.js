'use strict';

/* Controllers */

fiApp.controller('AccountAdminCtrl', ['$scope', '$modal', '$window',
                 'AccountAdminSrv', 'account', 'CurrentUserSrv', 'NotifSrv',
                  function($scope, $modal, $window, 
                           AccountAdminSrv, account, CurrentUserSrv, NotifSrv) {
  
  $scope.account = account;
  $scope.admins = account.admins;
  
  $scope.currentUser = '';
  
  CurrentUserSrv.getUser().then(function(resp) {
    $scope.currentUser = resp;
  });
  
  var updateAccount = function(account) {
    account.$update(function(val, resp) {
      $scope.account = val;
      NotifSrv.success();
    });
  }
  
  $scope.saveAccount = function(account, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      updateAccount(account);
    }
  }
  
  $scope.deleteConfirm = function(user) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/account/account-delete.html',
        controller: deleteAccountCtrl,
        resolve: {
          account: function() { return account; }
        }
      })
      .result.then(function(account) {
        deleteAccount(account);
      });
  }
  
  var deleteAccountCtrl = function($scope, $modalInstance, account) {
    $scope.account = account;
    $scope.delete = function() {
      $modalInstance.close($scope.account);
    }
  }
  
  var deleteAccount = function(account) {
    account.$delete(function() {
      $window.location.href = '/done';
    });
  }
  
}]);
