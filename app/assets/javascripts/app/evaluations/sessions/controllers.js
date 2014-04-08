'use strict';

/* Controllers */

fiApp.controller('EvaluationSessionsCtrl', ['$scope', 'EvaluationSessionsSrv', 'NotifSrv', 'sessions',
                  function($scope, EvaluationSessionsSrv, NotifSrv, sessions) {
  
  $scope.sessions = sessions;
  
  var createSession = function(newSession) {
    EvaluationSessionsSrv.save(newSession, function(val, resp) {
      $scope.sessions.push(val);
      $scope.eSession = {};
      $scope.eSessionForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateSession = function(session) {
    session.$update(function(val, resp) {
      var session = _.find($scope.sessions, function(s) {
        return s.id === val.id;
      });
      _.extend(session, val); // update object with returned values
      $scope.eSession = {};
      $scope.eSessionForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveSession = function(session, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (session.id) {
        updateSession(session);
      }
      else {
        createSession(session);
      }
    }
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eSession = {};
    $scope.eSessionForm.$setPristine();
  }
  
  $scope.deleteSession = function(session) {
    session.$delete().then(function() {
      $scope.sessions = _.without($scope.sessions, session);
      NotifSrv.success();
    });
  }
  
}]);
