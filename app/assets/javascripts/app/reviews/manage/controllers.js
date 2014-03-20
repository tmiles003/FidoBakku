'use strict';

/* Controllers */

fiApp.controller('ReviewsManageCtrl', ['$scope', 'ReviewsSrv', 'UserReviewsSrv', 
                    'NotifSrv', '$routeParams', '$http', 'userReviews', 
                  function($scope, Reviews, UserReviewsSrv, NotifSrv, $routeParams, $http, userReviews) {
  
  $scope.reviewId = $routeParams.id;
  $scope.userReviews = userReviews; // get user reviews for this review
  $http.get('/api/users/list').success(function(data) { 
    $scope.users = data; 
  });
  $http.get('/api/forms/list').success(function(data) { 
    $scope.forms = data; 
  });
  
  var createUserReview = function(newUserReview) {
    UserReviewsSrv.save({ user_review: newUserReview, review_id: $scope.reviewId }, function(val, resp) {
      $scope.userReviews = UserReviewsSrv.query({ review_id: $scope.reviewId }); // improve
      $scope.editableUserReview = {};
      $scope.editableUserReviewForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
      // $scope.errorName = resp.data.name[0]; // clean this up a bit...
    });
  }
  
  var updateUserReview = function(userReview) {
    userReview.$update({ review_id: $scope.reviewId }, function(val, resp) {
      $scope.userReviews = UserReviewsSrv.query({ review_id: $scope.reviewId }); // improve
      $scope.editableUserReview = {};
      $scope.editableUserReviewForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
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
      // NotifSrv.error('Error');
    }
  }
  
  $scope.editUserReview = function(userReview) {
    $scope.editableUserReview = angular.copy(userReview);
  }
  
  $scope.deleteUserReview = function(userReview) {
    userReview.$delete(function() {
      $scope.userReviews = _.without($scope.userReviews, userReview);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);
