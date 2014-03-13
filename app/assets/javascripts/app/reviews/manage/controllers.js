'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', 'UserReviewsSrv', '$routeParams', '$http', 
                  function($scope, UserReviews, $routeParams, $http) {
  
  $scope.reviewId = $routeParams.id;
  $scope.userReviews = UserReviews.query({ id: $scope.reviewId });
  // $scope.users = [];
  $http.get('/api/users/list').success(function(data) { 
    $scope.users = data; 
  });
  // $scope.forms = [];
  $http.get('/api/forms/list').success(function(data) { 
    $scope.forms = data; 
  });
  
  var createUserReview = function(newUserReview) {
    UserReview.save({ user_review: newUserReview, review_id: $scope.reviewId }, 
      function(val, resp) {
        $scope.userReviews = UserReviews.query({ id: $scope.reviewId }); // can i do this better?
        $scope.editableUserReview = {};
        $scope.editableUserReviewForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateUserReview = function(userReview) {
    userReview.$update(function(val, resp) {
      $scope.userReviews = UserReviews.query({ id: $scope.reviewId });
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
