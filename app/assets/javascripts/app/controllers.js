'use strict';

/* Controllers */

fiApp.controller('FooterCtrl', ['$scope', 'UsersAdminSrv', 'SessionSrv', 
                  function($scope, UsersAdminSrv, SessionSrv) {
  
  $scope.user = '';
  UsersAdminSrv.current(function(user) { // FIXME
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
