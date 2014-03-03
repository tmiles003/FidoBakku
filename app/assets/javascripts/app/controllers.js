'use strict';

/* Controllers */

angular.module('fbApp.controllers', [])

  .controller('GreetingCtrl', ['$scope', function($scope) {
    $scope.greeting = 'Hola!';
  }])
  
  .controller('UserFormCtrl', ['$scope', function($scope) {
    //
  }])
  
  .controller('UserListCtrl', ['$scope', 'UserService', function($scope, UserService) {
    // $scope.greeting = 'Users list';
    $scope.users = UserService.getUserList();
  }])
;
