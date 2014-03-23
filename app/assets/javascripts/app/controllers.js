'use strict';

/* Controllers */

fiApp.controller('FooterCtrl', ['$scope', 'SessionSrv', 
                  function($scope, SessionSrv) {
  
  $scope.user = '';
  $scope.account = '';
  
  SessionSrv.getAccount().then(function(re) {
    $scope.account = re.account;
  });
  SessionSrv.getUser().then(function(re) {
    $scope.user = re.user;
  });
  
  /* SessionSrv.getData(function(data) {
    $scope.user = data.user.name;
    $scope.account = data.account.name;
  }); */
  
}]);
