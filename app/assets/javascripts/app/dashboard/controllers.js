'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', 'dashboard', 'CurrentUserSrv', 
                 function($scope, dashboard, CurrentUserSrv) {
  
  $scope.user = dashboard.user;
  $scope.role = dashboard.user.role;
  
  $scope.user_evaluations = dashboard.user_evaluations;
  $scope.goals = dashboard.goals;
  $scope.evaluations = dashboard.evaluations;
  
  $scope.feedbacks = dashboard.feedbacks;
  $scope.teams = dashboard.teams;
  $scope.users = dashboard.users;
  
  // set user's team as default
  $scope.team_id = '';
  CurrentUserSrv.getUser().then(function(currentUser) {
    $scope.team_id = currentUser.team_id;
  });
  
}]);
