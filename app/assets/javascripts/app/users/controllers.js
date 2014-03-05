'use strict';

/* Controllers */

fbApp.controller('UserFormCtrl', ['$scope', 'UserService', function($scope, UserService) {
  
  $scope.createUser = function(formData) {
    UserService.createUser(formData).then(function(res) {
      $scope.formData = {};
      $scope.newUserForm.$setPristine();
    });
  }
  
}]);
  
fbApp.controller('UserListCtrl', ['$scope', 'UserService', function($scope, UserService) {
  
  $scope.$on('users.update', function(event) {
    UserService.getUserList().then(function(res) {
      $scope.userList = res.data;
    });
  });
  
  UserService.getUserList().then(function(res) {
    $scope.userList = res.data;
  });
  
}]);
