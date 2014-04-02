'use strict';

/* Controllers */

fiApp.controller('FooterCtrl', ['$scope', 'UsersSrv', 'SessionSrv', 
                  function($scope, UsersSrv, SessionSrv) {
  
  $scope.user = '';
  UsersSrv.current(function(user) {
    $scope.user = user;
  });
  
  $scope.account = '';
  SessionSrv.getAccount().then(function(re) {
    $scope.account = re.account;
  });
  
  /* SessionSrv.getData(function(data) {
    $scope.user = data.user.name;
    $scope.account = data.account.name;
  }); */
  
}]);
