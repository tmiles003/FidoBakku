'use strict';

/* Controllers */

fiApp.controller('ReviewsCtrl', ['$scope', 'ReviewsSrv', 'NotifSrv', 'reviews',
                  function($scope, ReviewsSrv, NotifSrv, reviews) {
  
  $scope.reviews = reviews;
  
  var createReview = function(newReview) {
    ReviewsSrv.save(newReview, function(val, resp) {
      $scope.reviews = ReviewsSrv.query(); // improve
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
      // $scope.errorName = resp.data.name[0]; // clean this up a bit...
    });
  }
  
  var updateReview = function(review) {
    review.$update(function(val, resp) {
      $scope.reviews = ReviewsSrv.query(); // improve
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
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
      // NotifSrv.error('Error'); // improve
    }
  }
  
  $scope.editReview = function(review) {
    $scope.editableReview = angular.copy(review);
  }
  
  $scope.deleteReview = function(review) {
    review.$delete().then(function() {
      $scope.reviews = _.without($scope.reviews, review);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);
