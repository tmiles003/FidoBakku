'use strict';

/* Controllers */

fiApp.controller('ReviewsCtrl', ['$scope', 'ReviewsSrv', 'NotifSrv', 'reviews',
                  function($scope, ReviewsSrv, NotifSrv, reviews) {
  
  $scope.reviews = reviews;
  $scope.states = [{s:'setup',l:'Setup'},{s:'review',l:'Review'},{s:'feedback',l:'Feedback'},{s:'closed',l:'Closed'},{s:'archived',l:'Archived'}];
  
  var createReview = function(newReview) {
    ReviewsSrv.save(newReview, function(val, resp) {
      $scope.reviews.push(val);
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateReview = function(review) {
    review.$update(function(val, resp) {
      var review = _.find($scope.reviews, function(r) {
        return r.id === val.id;
      });
      _.extend(review, val); // update object with returned values
      $scope.editableReview = {};
      $scope.editableReviewForm.$setPristine();
      NotifSrv.success();
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
  }
  
  $scope.editReview = function(review) {
    $scope.editableReview = angular.copy(review);
  }
  
  $scope.deleteReview = function(review) {
    review.$delete().then(function() {
      $scope.reviews = _.without($scope.reviews, review);
      NotifSrv.success();
    });
  }
  
}]);
