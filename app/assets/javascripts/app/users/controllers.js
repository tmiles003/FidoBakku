'use strict';

/* Controllers */

fiApp.controller('UsersCtrl', ['$scope', 'UsersSrv', 'users', 'NotifSrv', 
                  function($scope, UsersSrv, users, NotifSrv) {
  
  $scope.users = users;
  $scope.roles = [];
  UsersSrv.getRoles(function(roles) {
    $scope.roles = roles;
  });
  
  var createUser = function(newUser) {
    UsersSrv.save(newUser, function(val, resp) {
      $scope.users.push(val);
      $scope.editableUser = {};
      $scope.editableUserForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateUser = function(user) {
    user.$update(function(val, resp) {
      var user = _.find($scope.users, function(u) {
        return u.id === val.id;
      });
      _.extend(user, val); // update object with returned values
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
  }
  
  $scope.editUser = function(user) {
    $scope.editableUser = angular.copy(user);
  }
  
  $scope.deleteUser = function(user) {
    user.$delete(function() {
      $scope.users = _.without($scope.users, user); // "blind-up" row before trashing?
      NotifSrv.success();
    });
  }
  
}]);
