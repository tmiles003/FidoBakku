'use strict';

/* Controllers */

fiApp.controller('UsersCtrl', ['$scope', 'UsersSrv', 'users', 'TeamsSrv', 'NotifSrv', 
                  function($scope, UsersSrv, users, TeamsSrv, NotifSrv) {
  
  $scope.users = users;
  $scope.roles = [];
  UsersSrv.getRoles(function(roles) {
    $scope.roles = roles;
  });
  $scope.teams = [];
  TeamsSrv.query(function(teams) {
    $scope.teams = teams;
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
  
  // team stuff
  
  var createTeam = function(newTeam) {
    TeamsSrv.save(newTeam, function(val, resp) {
      $scope.teams.push(val);
      $scope.editableTeam = {};
      $scope.editableTeamForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateTeam = function(team) {
    team.$update(function(val, resp) {
      var team = _.find($scope.team, function(t) {
        return t.id === val.id;
      });
      _.extend(team, val); // update object with returned values
      $scope.editableTeam = {};
      $scope.editableTeamForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveTeam = function(team, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (team.id) {
        updateTeam(team);
      }
      else {
        createTeam(team);
      }
    }
  }
  
  $scope.editTeam = function(team) {
    $scope.editableTeam = angular.copy(team);
  }
  
  $scope.deleteTeam = function(team) {
    team.$delete(function() {
      $scope.teams = _.without($scope.teams, team);
      NotifSrv.success();
    });
  }
  
}]);