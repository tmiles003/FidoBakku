'use strict';

/* Controllers */

fiApp.controller('EvaluationsCtrl', ['$scope', 'EvaluationsSrv', 'UsersSrv', 'NotifSrv', 'session', 'evaluations',
                  function($scope, EvaluationsSrv, UsersSrv, NotifSrv, session, evaluations) {
  
  $scope.session = session;
  $scope.evaluations = evaluations;
  $scope.users = [];
  UsersSrv.query(function(users) {
    $scope.users = users;
  });
  
  var createEvaluation = function(newEvaluation) {
    EvaluationsSrv.save({ session_id: $scope.session.id, evaluation: newEvaluation }, function(val, resp) {
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
  
  $scope.deleteEvaluation = function(evaluation) {
    evaluation.$delete().then(function() {
      $scope.evaluations = _.without($scope.evaluations, evaluation);
      NotifSrv.success();
    });
  }
  
}]);
