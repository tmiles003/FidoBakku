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
  
  var createEvaluation = function(newEvaluation) {
    EvaluationsAdminSrv.save({ session_id: $scope.session.id, evaluation: newEvaluation }, function(val, resp) {
      $scope.evaluations.push(val);
      $scope.eEvaluation = {};
      $scope.eEvaluationForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveEvaluation = function(evaluation, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      createEvaluation(evaluation);
    }
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eEvaluation = {};
    $scope.eEvaluationForm.$setPristine();
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
    $scope.submitted = false;
    $scope.eEvaluation = {};
    $scope.eEvaluationForm.$setPristine();
    EvaluationsAdminSrv.delete({ id: evaluation.id }, function() {
      $scope.evaluations = _.without($scope.evaluations, evaluation);
      NotifSrv.success();
    });
  }
  
}]);
