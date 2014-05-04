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
  
  $scope.updateFeedback = function(comment, feedback) {
    CommentsSrv.update(comment, function(val, resp) {
      $scope.comment = val;
      NotifSrv.success();
    });
    FeedbackSrv.update({ 
        id: feedback.id, 
        rating: feedback.rating, 
        done: feedback.done }, function(val, resp) {
      NotifSrv.success();
    })
  }

}]);
