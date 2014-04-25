'use strict';

/* Controllers */

fiApp.controller('EvaluationsAdminCtrl', ['$scope', '$modal', 
                 'EvaluationsAdminSrv', 'NotifSrv', 'session', 
                  function($scope, $modal, 
                           EvaluationsAdminSrv, NotifSrv, session) {
  
  $scope.session = session;
  $scope.evaluations = session.evaluations;
  $scope.teams = session.teams;
  $scope.users = session.users;
  
  $scope.createEvaluation = function(user_id) {
    EvaluationsAdminSrv.save({ session_id: $scope.session.id, user_id: user_id }, function(val, resp) {
      $scope.evaluations.push(val);
      NotifSrv.success();
    });
  }
  
  $scope.setMode = function(evaluation, mode) {
    evaluation.mode = mode;
    EvaluationsAdminSrv.update(evaluation, function() {
      NotifSrv.success();
    });
  }
  
  $scope.deleteConfirm = function(evaluation) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/evaluations/evaluation-delete.html',
        controller: deleteEvaluationCtrl,
        resolve: {
          evaluation: function() { return evaluation; }
        }
      })
      .result.then(function(evaluation) {
        deleteEvaluation(evaluation);
      });
  }
  
  var deleteEvaluationCtrl = function($scope, $modalInstance, evaluation) {
    $scope.evaluation = evaluation;
    $scope.delete = function() {
      $modalInstance.close($scope.evaluation);
    }
  }
  
  var deleteEvaluation = function(evaluation) {
    EvaluationsAdminSrv.delete({ id: evaluation.id }, function() {
      $scope.evaluations = _.without($scope.evaluations, evaluation);
      NotifSrv.success();
    });
  }
  
}]);
