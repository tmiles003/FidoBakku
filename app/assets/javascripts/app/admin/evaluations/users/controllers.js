'use strict';

/* Controllers */

fiApp.controller('UserEvaluationsAdminCtrl', ['$scope', 
                 'UserEvaluationsAdminSrv', 'TeamsAdminSrv', 'UsersAdminSrv', 'NotifSrv', 'evaluation', 
                  function($scope, 
                           UserEvaluationsAdminSrv, TeamsAdminSrv, UsersAdminSrv, NotifSrv, evaluation) {
  
  $scope.evaluation = evaluation;
  $scope.userEvaluations = evaluation.userEvaluations;
  
  $scope.teams = [];
  TeamsAdminSrv.query(function(teams) {
    $scope.teams = teams;
  });
  
  $scope.users = [];
  UsersAdminSrv.query(function(users) {
    $scope.users = users;
  });
  
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
