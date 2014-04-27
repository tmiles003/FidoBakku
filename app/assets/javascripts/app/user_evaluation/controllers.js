'use strict';

/* Controllers */

fiApp.controller('UserEvaluationCtrl', ['$scope', 
                 'UserEvaluationSrv', 'userEvaluation', 'CommentsSrv', 'FormCompSrv', 'NotifSrv', 
                  function($scope, 
                           UserEvaluationSrv, userEvaluation, CommentsSrv, FormCompSrv, NotifSrv) {
  
  $scope.userEvaluation = userEvaluation;
  $scope.form_parts = userEvaluation.evaluation.form_parts;
  $scope.ratings = angular.fromJson(userEvaluation.ratings);
  $scope.comment = userEvaluation.comment;
  
  $scope.$watch('ratings', function(newVal, oldVal) {
    if (newVal !== oldVal) {
      // no-fuss update, nothing returned
      UserEvaluationSrv.update({ id: $scope.userEvaluation.id }, { 
        ratings: JSON.stringify(newVal) 
      }, function(progress) {
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
