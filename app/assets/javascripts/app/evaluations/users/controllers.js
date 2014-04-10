'use strict';

/* Controllers */

fiApp.controller('UserEvaluationsCtrl', ['$scope', 
                 'UserEvaluationsSrv', 'TeamsSrv', 'UsersSrv', 'NotifSrv', 'evaluation', 'userEvaluations',
                  function($scope, 
                           UserEvaluationsSrv, TeamsSrv, UsersSrv, NotifSrv, evaluation, userEvaluations) {
  
  $scope.evaluation = evaluation;
  $scope.userEvaluations = userEvaluations; console.log( userEvaluations );
  
  $scope.teams = [];
  TeamsSrv.query(function(teams) {
    $scope.teams = teams;
  });
  
  $scope.users = [];
  UsersSrv.query(function(users) {
    $scope.users = users;
  });
  
  $scope.assign = function(evaluator_id) {
    var data = {};
    data.user_id = $scope.evaluation.user_id;
    data.evaluation_id = $scope.evaluation.id;
    data.form_id = $scope.evaluation.user.form.id;
    data.evaluator_id = evaluator_id;
    // console.log( data );
    UserEvaluationsSrv.save({ user_evaluation: data }, function(userEvaluation) {
      console.log( userEvaluation );
    });
  }
  
  $scope.delete = function() {
    console.log('bye');
  }
  
}]);
