'use strict';

/* Controllers */

fiApp.controller('ReviewsManageCtrl', ['$scope', 'ReviewsSrv', 'UserReviewsSrv', '$routeParams', '$http', 
                  function($scope, Reviews, UserReviews, $routeParams, $http) {
  
  $scope.reviewId = $routeParams.id;
  $scope.userReviews = UserReviews.query({ review_id: $scope.reviewId }); // get user reviews for this review
  $http.get('/api/users/list').success(function(data) { 
    $scope.users = data; 
  });
  $http.get('/api/forms/list').success(function(data) { 
    $scope.forms = data; 
  });
  
  var createUserReview = function(newUserReview) {
    UserReviews.save({ user_review: newUserReview, review_id: $scope.reviewId }, 
      function(val, resp) {
        $scope.userReviews = UserReviews.query({ review_id: $scope.reviewId }); // can i do this better?
        $scope.editableUserReview = {};
        $scope.editableUserReviewForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateUserReview = function(userReview) {
    userReview.$update({ review_id: $scope.reviewId }, function(val, resp) {
      $scope.userReviews = UserReviews.query({ review_id: $scope.reviewId });
      $scope.editableUserReview = {};
      $scope.editableUserReviewForm.$setPristine();
    });
  }
  
  $scope.saveUserReview = function(userReview, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (userReview.id) {
        updateUserReview(userReview);
      }
      else {
        createUserReview(userReview);
      }
    }
    else {
      // console.log('form not valid');
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
