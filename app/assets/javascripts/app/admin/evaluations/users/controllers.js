'use strict';

/* Controllers */

fiApp.controller('UserEvaluationsAdminCtrl', ['$scope', '$modal',
                 'UserEvaluationsAdminSrv', 'NotifSrv', 'evaluation', 
                  function($scope, $modal, 
                           UserEvaluationsAdminSrv, NotifSrv, evaluation) {
  
  $scope.evaluation = evaluation;
  $scope.form = evaluation.form;
  $scope.user_evaluations = evaluation.user_evaluations;
  $scope.teams = evaluation.teams;
  $scope.users = evaluation.users;
  
  $scope.createUserEvaluation = function(user_id) {
    UserEvaluationsAdminSrv.save({ evaluation_id: $scope.evaluation.id, evaluator_id: user_id }, function(val, resp) {
      $scope.user_evaluations.push(val);
      NotifSrv.success();
    });
  }
  
  $scope.deleteConfirm = function(userEvaluation) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/evaluations/user-evaluation-delete.html',
        controller: deleteUserEvaluationCtrl,
        resolve: {
          userEvaluation: function() { return userEvaluation; }
        }
      })
      .result.then(function(userEvaluation) {
        deleteUserEvaluation(userEvaluation);
      });
  }
  
  var deleteUserEvaluationCtrl = function($scope, $modalInstance, userEvaluation) {
    $scope.userEvaluation = userEvaluation;
    $scope.delete = function() {
      $modalInstance.close($scope.userEvaluation);
    }
  }
  
  var deleteUserEvaluation = function(userEvaluation) {
    UserEvaluationsAdminSrv.delete({ id: userEvaluation.id }, function() {
      $scope.user_evaluations = _.without($scope.user_evaluations, userEvaluation);
      // NotifSrv.success();
    });
  }
  
}]);
