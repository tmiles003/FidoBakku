'use strict';

/* Controllers */

fiApp.controller('EvaluationsAdminCtrl', ['$scope', '$modal', 
                 'EvaluationsAdminSrv', 'UsersAdminSrv', 'NotifSrv', 'session', 'evaluations',
                  function($scope, $modal, 
                           EvaluationsAdminSrv, UsersAdminSrv, NotifSrv, session, evaluations) {
  
  $scope.session = session;
  $scope.evaluations = evaluations;
  $scope.users = [];
  UsersAdminSrv.query(function(users) {
    $scope.users = users;
  });
  
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
    evaluation.$delete(function() {
      $scope.evaluations = _.without($scope.evaluations, evaluation);
      NotifSrv.success();
    });
  }
  
}]);
