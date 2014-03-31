'use strict';

/* Controllers */

fiApp.controller('GoalCtrl', ['$scope', 'GoalsSrv', 'goal', 'NotifSrv', 
                  function($scope, GoalsSrv, goal, NotifSrv) {
  
  $scope.goal = goal;
  
}]);
