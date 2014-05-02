'use strict';

/* Controllers */

fiApp.controller('UserEvaluationCtrl', ['$scope', 
                 'UserEvaluationSrv', 'userEvaluation', 'CommentsSrv', 'FormCompSrv', 'NotifSrv', 
                  function($scope, 
                           UserEvaluationSrv, userEvaluation, CommentsSrv, FormCompSrv, NotifSrv) {
  
  $scope.userEvaluation = userEvaluation;
  $scope.evaluation = userEvaluation.evaluation;
  $scope.form_parts = userEvaluation.evaluation.form_parts;
  $scope.ratings = angular.fromJson(userEvaluation.ratings);
  $scope.progress = userEvaluation.progress;
  $scope.comment = userEvaluation.comment;
  
  $scope.$watch('ratings', function(newVal, oldVal) {
    if (newVal !== oldVal) {
      UserEvaluationSrv.update({ id: $scope.userEvaluation.id }, { 
        ratings: JSON.stringify(newVal) 
      }, function(val) {
        // only progress required for update return
        $scope.progress = val.progress;
        NotifSrv.success();
      });
    }
  }, true);
  
  $scope.compInUse = function(comp) {
    if (!comp.in_use) {
      comp.in_use = true;
      FormCompSrv.update({ id: comp.id });
    }
  }
  
  $scope.saveComment = function(comment) {
    CommentsSrv.update(comment, function(val, resp) {
      $scope.comment = val;
      NotifSrv.success();
    });
  }

}]);
