'use strict';

/* Controllers */

fiApp.controller('CurrentUserCtrl', ['$scope', 'CurrentUserSrv', 
                  function($scope, CurrentUserSrv) {
  
  $scope.currentUser = '';
  
  CurrentUserSrv.getUser().then(function(currentUser) {
    $scope.currentUser = currentUser;
  });
  
  $scope.$on('updateCurrUser', function() {
    CurrentUserSrv.getUser().then(function(currentUser) { 
      $scope.currentUser = currentUser;
    });
  });
  
}]);
