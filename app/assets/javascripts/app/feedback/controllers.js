'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', 
                 'FeedbackSrv', 'feedback', 'CommentsSrv', 'NotifSrv', 
                  function($scope, 
                           FeedbackSrv, feedback, CommentsSrv, NotifSrv) {
  
  $scope.feedback = feedback;
  $scope.form_parts = feedback.form_parts;
  $scope.comment = feedback.comment;
  $scope.comments = feedback.comments;
  
  $scope.evaluationComment = function(comment) {
    CommentsSrv.update(comment, function(val, resp) {
      $scope.comment = val;
      NotifSrv.success();
    });
  }
  
  $scope.$watch('feedback.rating', function(newVal, oldVal) {
    if (newVal !== oldVal) {
      FeedbackSrv.update({ id: feedback.id, rating: feedback.rating }, function(val, resp) {
        NotifSrv.success();
      });
    }
  });
  
  $scope.markEvaluationDone = function(feedback) {
    feedback.done = !feedback.done;
    FeedbackSrv.update({ id: feedback.id, done: feedback.done }, function(val, resp) {
      NotifSrv.success();
    });
  }

}]);
