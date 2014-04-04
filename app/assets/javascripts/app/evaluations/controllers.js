'use strict';

/* Controllers */

fiApp.controller('EvaluationsCtrl', ['$scope', 'EvaluationsSrv', 'NotifSrv', 'evaluations',
                  function($scope, EvaluationsSrv, NotifSrv, evaluations) {
  
  $scope.evaluations = evaluations;
  $scope.statuses = [];
  EvaluationsSrv.getStatuses(function(statuses) {
    $scope.statuses = statuses;
  });
  
  var createEvaluation = function(newEvaluation) {
    EvaluationsSrv.save(newEvaluation, function(val, resp) {
      $scope.evaluations.push(val);
      $scope.eEvaluation = {};
      $scope.eEvaluationForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateEvaluation = function(evaluation) {
    evaluation.$update(function(val, resp) {
      var evaluation = _.find($scope.evaluations, function(e) {
        return e.id === val.id;
      });
      _.extend(evaluation, val); // update object with returned values
      $scope.eEvaluation = {};
      $scope.eEvaluationForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveEvaluation = function(evaluation, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (evaluation.id) {
        updateEvaluation(evaluation);
      }
      else {
        createEvaluation(evaluation);
      }
    }
  }
  
  $scope.editEvaluation = function(evaluation) {
    $scope.eEvaluation = angular.copy(evaluation);
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eEvaluation = {};
    $scope.eEvaluationForm.$setPristine();
  }
  
  $scope.deleteEvaluation = function(evaluation) {
    evaluation.$delete().then(function() {
      $scope.evaluations = _.without($scope.evaluations, evaluation);
      NotifSrv.success();
    });
  }
  
}]);
