'use strict';

/* Controllers */

fiApp.controller('ReviewCtrl', ['$scope', 'ReviewSrv', function($scope, Review) {
  
  $scope.reviews = Review.query();
  
  var createReview = function(newReview) {
    Review.save(newReview, 
      function(val, resp) {
        $scope.reviews = Review.query(); // can i do this better?
        $scope.editableReview = {};
        $scope.editableReviewForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateReview = function(review) {
    review.$update(function(val, resp) {
      $scope.reviews = Review.query();
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
    });
  }
  
  $scope.saveReview = function(review) {
    $scope.errorName = null;
    if (review.id) {
      updateReview(review);
    }
    else {
      createReview(review);
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
