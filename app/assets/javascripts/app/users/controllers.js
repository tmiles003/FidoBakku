'use strict';

/* Controllers */

fiApp.controller('UsersCtrl', ['$scope', 'UsersSrv', 'NotifSrv', function($scope, Users, NotifSrv) {
  
  $scope.users = Users.query();
  $scope.roles = [{s:'user',l:'User'},{s:'manager',l:'Manager'},{s:'admin',l:'Admin'}]; // make this better
  
  var createUser = function(newUser) {
    $scope.users.push(Users.save(newUser));
    $scope.editableUser = {};
    $scope.editableUserForm.$setPristine();
  }
  
  var updateUser = function(user) {
    user.$update().then(function() {
      $scope.users = Users.query();
      $scope.editableUser = {};
      $scope.editableUserForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveUser = function(user, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (user.id) {
        updateUser(user);
      }
      else {
        createUser(user);
      }
    }
    else {
      // console.log('form has errors');
    }
  }
  
  $scope.editUser = function(user) {
    $scope.editableUser = angular.copy(user);
  }
  
  $scope.deleteUser = function(user) {
    user.$delete().then(function() {
      $scope.users = _.without($scope.users, user);
    });
  }
  
}]);
