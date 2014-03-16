'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', 'UserReviewsSrv', '$routeParams', 
                  function($scope, UserReviews, $routeParams) {
  
  $scope.review = UserReviews.get({ id: $routeParams.id });
  $scope.scores = [];
     
}]);
