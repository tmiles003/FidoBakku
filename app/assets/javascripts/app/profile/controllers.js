'use strict';

/* Controllers */

fiApp.controller('ProfileCtrl', ['$scope', '$http', 'NotifSrv', 
                 function($scope, $http, NotifSrv) {
  
  $scope.saveForm = function(passwordForm) {
    $http.put('/api/profile.json', passwordForm)
      .success(function() {
        NotifSrv.success();
      });
  }
  
}]);
