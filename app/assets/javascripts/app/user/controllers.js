'use strict';

/* Controllers */

fiApp.controller('UserCtrl', ['$scope', 'GoalsSrv', 'goals', 'NotifSrv', 
                  function($scope, GoalsSrv, goals, NotifSrv) {
  
  $scope.goals = goals;
  
  $scope.dueDate = function() {
    $('.input-group.date').datepicker({
      format: 'dd/mm/yyyy',
      startDate: '-1d',
      // endDate: '+3y',
      startView: 2,
      // weekStart: 1,
      orientation: 'auto',
      clearBtn: true,
      keyboardNavigation: false,
      autoclose: true
    });
  }
  
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
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
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
