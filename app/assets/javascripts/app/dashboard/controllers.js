'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', '$http', function($scope, $http) {
  
  $scope.evaluations = [];
  $http.get('/api/dashboard/evaluations').success(function(evaluations) {
    $scope.evaluations = evaluations;
  });
  
  $scope.feedbacks = [];
  $http.get('/api/dashboard/feedbacks').success(function(feedbacks) {
    $scope.feedbacks = feedbacks;
  });
  
}]);
