'use strict';

/* Controllers */

fiApp.controller('UsersCtrl', ['$scope', 'UsersSrv', 'NotifSrv', function($scope, Users, NotifSrv) {
  
  $scope.users = Users.query();
  $scope.roles = [{s:'user',l:'User'},{s:'manager',l:'Manager'},{s:'admin',l:'Admin'}]; // improve
  
  var createUser = function(newUser) {
    Users.save(newUser, function(val, resp) {
      $scope.users.push(val);
      $scope.editableUser = {};
      $scope.editableUserForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
  var updateUser = function(user) {
    user.$update(function(val, resp) {
      $scope.users = Users.query(); // improve
      $scope.editableUser = {};
      $scope.editableUserForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
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
      // NotifSrv.error('Error');
    }
  }
  
  $scope.editUser = function(user) {
    $scope.editableUser = angular.copy(user);
  }
  
  $scope.deleteUser = function(user) {
    user.$delete(function() {
      $scope.users = _.without($scope.users, user);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);
