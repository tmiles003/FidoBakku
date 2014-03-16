'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', '$http', 'UserReviewsSrv', '$routeParams', 
                  function($scope, $http, UserReviews, $routeParams) {
  
  var userReview = UserReviews.get({ id: $routeParams.id }, function(resp) {
    $scope.review = resp.user_review.review;
    $scope.form = resp.user_review.form;
    $scope.scores = angular.fromJson(resp.user_review.scores);
    $scope.user = resp.user_review.user;
    $scope.reviewer = resp.user_review.reviewer;

    $scope.$watchCollection('scores', function() {
      UserReviews.update({ id: $routeParams.id }, 
        { review_id: $scope.review.id, scores: JSON.stringify($scope.scores) });
    });
  
  });
}]);
