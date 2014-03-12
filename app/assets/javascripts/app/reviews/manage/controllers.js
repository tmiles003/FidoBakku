'use strict';

/* Controllers */

fiApp.controller('UserReviewCtrl', ['$scope', 'UserReviewSrv', '$routeParams', function($scope, UserReview, $routeParams) {
  
  $scope.userReviewId = $routeParams.id;
  $scope.userReviews = UserReview.query({ id: $scope.userReviewId });
  
  var createUserReview = function(newUserReview) {
    Review.save(newUserReview, 
      function(val, resp) {
        $scope.userReviews = UserReview.query({ user_review_id: $scope.userReviewId }); // can i do this better?
        $scope.editableUserReview = {};
        $scope.editableUserReviewForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateUserReview = function(userReview) {
    userReview.$update(function(val, resp) {
      $scope.userReviews = UserReview.query({ user_review_id: $scope.userReviewId });
      $scope.editableUserReview = {};
      $scope.editableUserReviewForm.$setPristine();
    });
  }
  
  $scope.saveUserReview = function(userReview) {
    $scope.errorName = null;
    if (userReview.id) {
      updateUserReview(userReview);
    }
    else {
      createUserReview(userReview);
    }
  }
  
  $scope.editUserReview = function(userReview) {
    $scope.editableUserReview = angular.copy(userReview);
  }
  
  $scope.deleteUserReview = function(userReview) {
    userReview.$delete().then(function() {
      $scope.userReviews = _.without($scope.userReviews, userReview);
    });
  }
  
}]);
