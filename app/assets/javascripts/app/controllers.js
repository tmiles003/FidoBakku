'use strict';

/* Controllers */

angular.module('fbApp.controllers', [])

  .controller('GreetingCtrl', ['$scope', function($scope) {
    $scope.greeting = 'Hola!';
  }])
  
  .controller('UserFormCtrl', ['$scope', function($scope) {
    // $scope.greeting = 'UserFormCtrl';
  }])
  
  .controller('UserListCtrl', ['$scope', 'UserService', function($scope, UserService) {
    UserService.getUserList().then(function(res) {
      $scope.users = res.data;
    });
  }])
;
