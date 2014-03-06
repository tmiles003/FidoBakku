'use strict';

/* Controllers */

var UserCtrl = angular.module('fiUserController', []);

UserCtrl.controller('UserCtrl', ['$scope', 'User', function($scope, User) {
  
  $scope.users = User.query();
  
  var createUser = function(newUser) {
    $scope.users.push(User.save(newUser));
    $scope.editableUser = {};
    $scope.editableUserForm.$setPristine();
  }
  
  var updateUser = function(user) {
    user.$update().then(function() {
      $scope.editableUser = {};
      $scope.editableUserForm.$setPristine();
    });
  }
  
  $scope.saveUser = function(user) {
    if (user.id) {
      updateUser(user);
    }
    else {
      createUser(user);
    }
  }
  
  $scope.editUser = function(user) {
    $scope.editableUser = user;
  }
  
  $scope.deleteUser = function(user) {
    user.$delete().then(function() {
      $scope.users = _.without($scope.users, user);
    });
  }
  
}]);
