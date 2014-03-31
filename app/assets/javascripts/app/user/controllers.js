'use strict';

/* Controllers */

fiApp.controller('UserCtrl', ['$scope', 'goals', 'NotifSrv', 
                  function($scope, goals, NotifSrv) {
  
  $scope.goals = goals;
  
}]);
