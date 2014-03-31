'use strict';

/* Controllers */

fiApp.controller('GoalsCtrl', ['$scope', 'GoalsSrv', 'goals', 'NotifSrv', 
                  function($scope, GoalsSrv, goals, NotifSrv) {
  
  $scope.goals = goals;
  
  var createGoal = function(newGoal) {
    GoalsSrv.save(newGoal, function(val, resp) {
      $scope.goals.push(val);
      $scope.eGoal = {};
      $scope.eGoalForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateGoal = function(goal) {
    goal.$update(function(val, resp) {
      var goal = _.find($scope.goals, function(g) {
        return g.id === val.id;
      });
      _.extend(goal, val); // update object with returned values
      $scope.eGoal = {};
      $scope.eGoalForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveGoal = function(goal, isValid) {
    $scope.goalFormSubmitted = true;
    if (isValid) {
      $scope.goalFormSubmitted = false;
      if (goal.id) {
        updateGoal(goal);
      }
      else {
        createGoal(goal);
      }
    }
  }
  
  $scope.editGoal = function(goal) {
    $scope.eGoal = angular.copy(goal);
  }
  
  $scope.deleteGoal = function(goal) {
    goal.$delete(function() {
      $scope.goals = _.without($scope.goals, goal);
      NotifSrv.success();
    });
  }

}]);
