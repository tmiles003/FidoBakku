'use strict';

/* Controllers */

fiApp.controller('UserReviewsCtrl', ['$scope', 'UserReviewsSrv', '$routeParams', 
                  function($scope, UserReviews, $routeParams) {
  
  /* UserReviews.getReview($routeParams.id).success(function(data) {
    $scope.review = data;
    // console.log( $scope.review );
  }); */
  
  console.log( UserReviews.get({ id: $routeParams.id }) );
     
}]);
