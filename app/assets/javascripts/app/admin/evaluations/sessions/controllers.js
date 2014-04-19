'use strict';

/* Controllers */

fiApp.controller('EvaluationSessionsAdminCtrl', ['$scope', '$modal', 
                 'EvaluationSessionsAdminSrv', 'NotifSrv', 'sessions',
                  function($scope, $modal, 
                           EvaluationSessionsAdminSrv, NotifSrv, sessions) {
  
  $scope.sessions = sessions;
  
  var createSession = function(newSession) {
    EvaluationSessionsAdminSrv.save(newSession, function(val, resp) {
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
  
  $scope.editSession = function(session) {
    $scope.eSession = angular.copy(session);
  }
  
  $scope.deleteConfirm = function(session) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/evaluations/session-delete.html',
        controller: deleteSessionCtrl,
        resolve: { 
          session: function() { return session; }
        }
      })
      .result.then(function(session) {
        deleteSession(session);
      });
  };
  
  var deleteSessionCtrl = function($scope, $modalInstance, session) {
    $scope.session = session;
    $scope.delete = function() {
      $modalInstance.close($scope.session);
    }
  }
  
  var deleteSession = function(session) {
    $scope.submitted = false;
    $scope.eSession = {};
    $scope.eSessionForm.$setPristine();
    EvaluationSessionsAdminSrv.delete({ id: session.id }, function() {
      $scope.sessions = _.without($scope.sessions, session);
      NotifSrv.success();
    });
  }
  
}]);
