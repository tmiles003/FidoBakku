'use strict';

/* Controllers */

fiApp.controller('ReviewsCtrl', ['$scope', 'ReviewsSrv', 'NotifSrv', 
                  function($scope, Reviews, NotifSrv) {
  
  $scope.reviews = Reviews.query();
  
  var createReview = function(newReview) {
    Reviews.save(newReview, function(val, resp) {
      $scope.reviews = Reviews.query(); // improve
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
      $scope.reviews = Reviews.query(); // improve
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
