'use strict';

/* Controllers */

fiApp.controller('UserEvaluationsAdminCtrl', ['$scope', 
                 'UserEvaluationsAdminSrv', 'NotifSrv', 'evaluation', 
                  function($scope, 
                           UserEvaluationsAdminSrv, NotifSrv, evaluation) {
  
  $scope.evaluation = evaluation;
  $scope.user_evaluations = evaluation.user_evaluations;
  $scope.teams = evaluation.teams;
  $scope.users = evaluation.users;
  
  $scope.assign = function(evaluator_id) {
    var data = {};
    // data.user_id = $scope.evaluation.user_id;
    data.evaluation_id = $scope.evaluation.id;
    // data.form_id = $scope.evaluation.user.form.id;
    data.evaluator_id = evaluator_id;
    // console.log( data );
    UserEvaluationsAdminSrv.save({ user_evaluation: data }, function(userEvaluation) {
      console.log( userEvaluation );
    });
  }
  
  $scope.delete = function() {
    console.log('bye');
  }
  
}]);
