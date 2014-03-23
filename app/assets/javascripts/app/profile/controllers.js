'use strict';

/* Controllers */

fiApp.controller('ProfileCtrl', ['$scope', '$http', function($scope, $http) {
  
  $scope.saveForm = function(passwordForm) {
    $http.put('/api/profile.json', passwordForm)
      .success(function() {
        // console.log( 'all ok' );
      });
  }
  
}]);
