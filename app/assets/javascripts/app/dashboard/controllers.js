'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', 'dashboard', function($scope, dashboard) {
  
  $scope.users = dashboard.users; 
  $scope.teams = dashboard.teams; 
  
  $scope.evaluations = dashboard.evaluations;
  $scope.feedbacks = dashboard.feedbacks;
  
}]);
