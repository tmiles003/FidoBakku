'use strict';

/* Controllers */

fiApp.controller('UsersCtrl', ['$scope', 'UsersSrv', 'users', 'TeamsSrv', 'teams', 'NotifSrv', 
                  function($scope, UsersSrv, users, TeamsSrv, teams, NotifSrv) {
  
  $scope.users = users;
  $scope.teams = teams;
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
    $scope.userFormSubmitted = true;
    if (isValid) {
      $scope.userFormSubmitted = false;
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
      var team = _.find($scope.teams, function(t) {
        return t.id === val.id;
      });
      _.extend(team, val); // update object with returned values
      $scope.editableTeam = {};
      $scope.editableTeamForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveTeam = function(team, isValid) {
    $scope.teamFormSubmitted = true;
    if (isValid) {
      $scope.teamFormSubmitted = false;
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
    var teamId = team.id;
    team.$delete(function() {
      // update users with that team id
      _.each(_.where($scope.users, { team_id: teamId }), function(u) {
        u.team_id = null;
      });
      $scope.teams = _.without($scope.teams, team);
      NotifSrv.success();
    });
  }
  
}]);