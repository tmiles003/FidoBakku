'use strict';

/* Controllers */

fiApp.controller('CurrentUserCtrl', ['$scope', 'CurrentUserSrv', 
                  function($scope, CurrentUserSrv) {
  
  $scope.user = '';
  
  CurrentUserSrv.getUser().then(function(resp) {
    $scope.user = resp;
  });
  
  $scope.$on('updateCurrUser', function() {
    CurrentUserSrv.getUser().then(function(resp) { 
      $scope.user = resp;
    });
  });
  
}]);
