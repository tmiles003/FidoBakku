'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', '$http', 'UserReviewsSrv', 'NotifSrv', '$routeParams', 'review', 
                  function($scope, $http, UserReviewsSrv, NotifSrv, $routeParams, review) {
  
  $scope.review = review.user_review.review;
  $scope.form = review.user_review.form;
  $scope.scores = angular.fromJson(review.user_review.scores);
  $scope.reviewer = review.user_review.reviewer;

  var isLoading = true;
  $scope.$watchCollection('scores', function() {
    UserReviewsSrv.update({ id: $routeParams.id }, 
      { review_id: $scope.review.id, scores: JSON.stringify($scope.scores) }, function() {
        if (!isLoading) 
          NotifSrv.success();
        else 
          isLoading = false;
      });
  });
}]);

fiApp.controller('ReviewCommentCtrl', ['$scope', '$routeParams', 'ReviewCommentsSrv', 'NotifSrv',
                  function($scope, $routeParams, ReviewCommentsSrv, NotifSrv) {
  
  $scope.comment = ReviewCommentsSrv.get({ review_id: $routeParams.id });
  
  var updateComment = function(comment) {
    comment.$update({ review_id: $routeParams.id }, function(val, resp) {
      NotifSrv.success();
    });
  }
  
  $scope.saveComment = function(comment, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (comment.id) {
        updateComment(comment);
      }
    }
  }
  
}]);
