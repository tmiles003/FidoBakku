'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', '$http', 'UserReviewsSrv', 'NotifSrv', '$routeParams', 
                  function($scope, $http, UserReviews, NotifSrv, $routeParams) {
  
  var userReview = UserReviews.get({ id: $routeParams.id }, function(resp) {
    $scope.review = resp.user_review.review;
    $scope.form = resp.user_review.form;
    $scope.scores = angular.fromJson(resp.user_review.scores);
    $scope.reviewer = resp.user_review.reviewer;

    var isLoading = true;
    $scope.$watchCollection('scores', function() {
      UserReviews.update({ id: $routeParams.id }, 
        { review_id: $scope.review.id, scores: JSON.stringify($scope.scores) }, function() {
          if (!isLoading) 
            NotifSrv.success();
          else 
            isLoading = false;
        });
    });
  
  });
}]);

fiApp.controller('ReviewFeedbackCtrl', ['$scope', '$routeParams', 'ReviewFeedbackSrv', 'NotifSrv',
                  function($scope, $routeParams, ReviewFeedbackSrv, NotifSrv) {
  
  $scope.feedback = ReviewFeedbackSrv.get({ review_id: $routeParams.id });
  
  var updateFeedback = function(feedback) {
    feedback.$update({ review_id: $routeParams.id }, function(val, resp) {
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
  $scope.saveFeedback = function(feedback, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (feedback.id) {
        updateFeedback(feedback);
      }
    }
    else {
      // NotifSrv.error('Error');
    }
  }
  
}]);
