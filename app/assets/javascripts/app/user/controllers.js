'use strict';

/* Controllers */

fiApp.controller('UserCtrl', ['$scope', 'UserSrv', '$routeParams', 
                  function($scope, User, $routeParams) {
  
  User.getReview($routeParams.id).success(function(data) {
    $scope.review = data;
    // console.log( $scope.review );
  });
    
}]);
