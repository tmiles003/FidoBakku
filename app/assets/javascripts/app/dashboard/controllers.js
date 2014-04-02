'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', '$http', function($scope, $http) {
  
  $scope.reviews = [];
  /* $http.get('/api/dashboard/reviews').success(function(reviews) {
    $scope.reviews = reviews;
  }); */
  
  $scope.feedbacks = [];
  /* $http.get('/api/dashboard/feedbacks').success(function(feedbacks) {
    $scope.feedbacks = feedbacks;
  }); */
  
}]);
