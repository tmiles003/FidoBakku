'use strict';

/* Controllers */

fiApp.controller('ProfileCtrl', ['$scope', '$http', 'currentUser', 'NotifSrv', 
                 function($scope, $http, currentUser, NotifSrv) {
  
  $scope.currentUser = currentUser;
  
  $scope.updatePassword = function(passwordForm, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      $http.put('/api/profile', passwordForm).success(function() {
          $scope.submitted = false;
          $scope.password = {};
          $scope.passwordForm.$setPristine();
          NotifSrv.success();
        });
    }
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.password = {};
    $scope.passwordForm.$setPristine();
  }
  
}]);
