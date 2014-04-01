'use strict';

/* Controllers */

fiApp.controller('GoalsCtrl', ['$scope', 'GoalsSrv', 'goals', 'NotifSrv', 
                  function($scope, GoalsSrv, goals, NotifSrv) {
  
  $scope.goals = goals;
  
}]);
