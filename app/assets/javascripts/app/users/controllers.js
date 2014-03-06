'use strict';

/* Controllers */

fiApp.controller('UserFormCtrl', ['$scope', 'UserService', function($scope, UserService) {
  
  $scope.createUser = function(formData) {
    UserService.createUser(formData).then(function(res) {
      $scope.formData = {};
      $scope.newUserForm.$setPristine();
    });
  }
  
}]);
  
fiApp.controller('UsersCtrl', ['$scope', 'UserService', function($scope, UserService) {
  
  $scope.$on('users.update', function(event) {
    UserService.getUsers().then(function(res) {
      $scope.users = res.data;
    });
  });
  
  UserService.getUsers().then(function(res) {
    $scope.users = res.data;
  });
  
}]);
