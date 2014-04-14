'use strict';

/* Controllers */

fiApp.controller('UserCtrl', ['$scope', '$routeParams', 'user', 'GoalSrv', 'NotifSrv', 
                  function($scope, $routeParams, user, GoalSrv, NotifSrv) {
  
  $scope.user = user;
  $scope.goals = user.goals;
  $scope.evaluations = user.evaluations;
  
  var createGoal = function(newGoal) {
    _.extend(newGoal, { user_id: $routeParams.id }); // assign user_id to goal
    GoalSrv.save(newGoal, function(val, resp) {
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
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eGoal = {};
    $scope.eGoalForm.$setPristine();
  }
  
  $scope.deleteGoal = function(goal) {
    goal.$delete(function() {
      $scope.goals = _.without($scope.goals, goal);
      NotifSrv.success();
    });
  }

}]);
