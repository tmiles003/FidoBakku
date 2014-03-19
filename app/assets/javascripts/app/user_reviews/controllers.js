'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', '$http', 'UserReviewsSrv', '$routeParams', 
                  function($scope, $http, UserReviews, $routeParams) {
  
  var userReview = UserReviews.get({ id: $routeParams.id }, function(resp) {
    $scope.review = resp.user_review.review;
    $scope.form = resp.user_review.form;
    $scope.scores = angular.fromJson(resp.user_review.scores);
    $scope.reviewer = resp.user_review.reviewer;

    $scope.$watchCollection('scores', function() {
      UserReviews.update({ id: $routeParams.id }, 
        { review_id: $scope.review.id, scores: JSON.stringify($scope.scores) });
    });
  
  });
}]);

fiApp.controller('ReviewFeedbackCtrl', ['$scope', '$routeParams', 'ReviewFeedbackSrv', 
                  function($scope, $routeParams, ReviewFeedbackSrv) {
  
  $scope.feedback = ReviewFeedbackSrv.get({ review_id: $routeParams.id });
  
  var updateFeedback = function(feedback) {
    feedback.$update({ review_id: $routeParams.id }, function(val, resp) {
      // success
      console.log('done');
    });
  }
  
  $scope.saveFeedback = function(feedback, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      console.log( feedback );
      if (feedback.id) {
        updateFeedback(feedback);
      }
    }
    else {
      // console.log('form has errors');
    }
  }
  
}]);
