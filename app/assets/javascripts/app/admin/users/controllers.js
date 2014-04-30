'use strict';

/* Controllers */

fiApp.controller('UsersAdminCtrl', ['$scope', '$rootScope', '$modal', 
                 'UsersAdminSrv', 'users', 'TeamsAdminSrv', 'teams', 'CurrentUserSrv', 'NotifSrv', 
                  function($scope, $rootScope, $modal,
                           UsersAdminSrv, users, TeamsAdminSrv, teams, CurrentUserSrv, NotifSrv) {
  
  $scope.users = users;
  $scope.teams = teams;
  $scope.roles = [];
  UsersAdminSrv.getRoles(function(roles) {
    $scope.roles = roles;
  });
  
  // watch for changes to the current user, to update CurrentUserCtrl
  CurrentUserSrv.getUser().then(function(resp) {
    $scope.currentUser = _.find($scope.users, function(u) {
      return u.id === resp.id;
    });
    $scope.$watchCollection('currentUser', function() {
      CurrentUserSrv.setUser($scope.currentUser);
    });
  });
  
  var createUser = function(newUser) {
    UsersAdminSrv.save(newUser, function(val, resp) {
      $scope.users.push(val);
      $scope.eUser = {};
      $scope.eUserForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateUser = function(user) {
    UsersAdminSrv.update(user, function(val, resp) {
      var user = _.find($scope.users, function(u) {
        return u.id === val.id;
      });
      _.extend(user, val); // update object with returned values
      $scope.eUser = {};
      $scope.eUserForm.$setPristine();
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
    $scope.eUser = angular.copy(user);
  }
  
  $scope.clearUserForm = function() {
    $scope.userFormSubmitted = false;
    $scope.eUser = {};
    $scope.eUserForm.$setPristine();
  }
  
  $scope.deleteConfirm = function(user) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/users/user-delete.html',
        controller: deleteUserCtrl,
        resolve: {
          user: function() { return user; }
        }
      })
      .result.then(function(user) {
        deleteUser(user);
      });
  }
  
  var deleteUserCtrl = function($scope, $modalInstance, user) {
    $scope.user = user;
    $scope.delete = function() {
      $modalInstance.close($scope.user);
    }
  }
  
  var deleteUser = function(user) {
    $scope.userFormSubmitted = false;
    $scope.eUser = {};
    $scope.eUserForm.$setPristine();
    user.$delete(function() {
      $scope.users = _.without($scope.users, user);
      NotifSrv.success();
    });
  }
  
  // team stuff
  
  var createTeam = function(newTeam) {
    TeamsAdminSrv.save(newTeam, function(val, resp) {
      $scope.teams.push(val);
      $scope.eTeam = {};
      $scope.eTeamForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateTeam = function(team) {
    team.$update(function(val, resp) {
      var team = _.find($scope.teams, function(t) {
        return t.id === val.id;
      });
      _.extend(team, val); // update object with returned values
      $scope.eTeam = {};
      $scope.eTeamForm.$setPristine();
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
    $scope.eTeam = angular.copy(team);
  }
  
  $scope.clearTeamForm = function() {
    $scope.teamFormSubmitted = false;
    $scope.eTeam = {};
    $scope.eTeamForm.$setPristine();
  }
  
  $scope.deleteTeamConfirm = function(team) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/users/team-delete.html',
        controller: deleteTeamCtrl,
        resolve: {
          team: function() { return team; }
        }
      })
      .result.then(function(team) {
        deleteTeam(team);
      });
  }
  
  var deleteTeamCtrl = function($scope, $modalInstance, team) {
    $scope.team = team;
    $scope.delete = function() {
      $modalInstance.close($scope.team);
    }
  }
  
  var deleteTeam = function(team) {
    var teamId = team.id;
    team.$delete(function() {
      var teamUsers = _.where($scope.users, { team_id: teamId });
      _.each(teamUsers, function(u) {
        u.team_id = null;
      });
      $scope.teams = _.without($scope.teams, team);
      NotifSrv.success();
    });
  }
  
}]);