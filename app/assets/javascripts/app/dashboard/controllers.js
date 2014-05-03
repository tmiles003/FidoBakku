'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', 'dashboard', function($scope, dashboard) {
  
  $scope.users = dashboard.users; 
  $scope.teams = dashboard.teams; 
  
  $scope.user_evaluations = dashboard.user_evaluations;
  $scope.evaluations = dashboard.evaluations;
  
}]);
