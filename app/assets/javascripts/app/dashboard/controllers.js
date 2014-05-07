'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', 'dashboard', function($scope, dashboard) {
  
  $scope.user = dashboard.user;
  $scope.role = dashboard.user.role;
  
  $scope.user_evaluations = dashboard.user_evaluations;
  $scope.goals = dashboard.goals;
  $scope.evaluations = dashboard.evaluations;
  
  $scope.teams = dashboard.teams;
  $scope.users = dashboard.users;
  
}]);
