'use strict';

/* Controllers */

fiApp.controller('ProfileCtrl', ['$scope', '$http', 'NotifSrv', 
                 function($scope, $http, NotifSrv) {
  
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
