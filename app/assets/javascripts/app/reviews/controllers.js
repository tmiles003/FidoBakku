'use strict';

/* Controllers */

fiApp.controller('ReviewsCtrl', ['$scope', 'ReviewsSrv', function($scope, Reviews) {
  
  $scope.reviews = Reviews.query();
  
  var createReview = function(newReview) {
    Reviews.save(newReview, 
      function(val, resp) {
        $scope.reviews = Reviews.query(); // can i do this better?
        $scope.editableReview = {};
        $scope.editableReviewForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateReview = function(review) {
    review.$update(function(val, resp) {
      $scope.reviews = Reviews.query();
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
    });
  }
  
  $scope.saveReview = function(review, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (review.id) {
        updateReview(review);
      }
      else {
        createReview(review);
      }
    }
    else {
      // console.log('form not valid');
    }
  }
  
  $scope.editReview = function(review) {
    $scope.editableReview = angular.copy(review);
  }
  
  $scope.deleteReview = function(review) {
    review.$delete().then(function() {
      $scope.reviews = _.without($scope.reviews, review);
    });
  }
  
}]);
