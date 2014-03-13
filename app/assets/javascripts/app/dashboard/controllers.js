'use strict';

/* Controllers */

fiApp.controller('DashboardCtrl', ['$scope', '$http', function($scope, $http) {
  
  $scope.reviews = [];
  $http.get('/api/dashboard/reviews').success(function(data) {
    $scope.reviews = data;
  });
  
}]);
