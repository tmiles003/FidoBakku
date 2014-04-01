'use strict';

/* Controllers */

fiApp.controller('GoalsCtrl', ['$scope', 'user', 'GoalsSrv', 'goals', 'NotifSrv', 
                  function($scope, user, GoalsSrv, goals, NotifSrv) {
  
  $scope.user = user;
  $scope.goals = goals;
  $scope.teamGoals = [];
  GoalsSrv.team(function(teamGoals) {
    $scope.teamGoals = teamGoals;
  });
  
}]);
