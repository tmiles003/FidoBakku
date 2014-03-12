'use strict';

/* Controllers */

fiApp.controller('ProfileCtrl', ['$scope', '$http', function($scope, $http) {
  
  $scope.saveForm = function(passwordForm) {
    $http.post('/api/profile/update.json', passwordForm)
      .success(function() {
        // console.log( 'all ok' );
      });
  }
  
}]);
