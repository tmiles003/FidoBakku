'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', 
                 'FeedbackSrv', 'feedback', 'CommentsSrv', 'NotifSrv', 
                  function($scope, 
                           FeedbackSrv, feedback, CommentsSrv, NotifSrv) {
  
  $scope.feedback = feedback;
  $scope.form_parts = feedback.form_parts;
  $scope.comment = $scope.feedback.comment;
  
  $scope.saveComment = function(comment) {
    CommentsSrv.update(comment, function(val, resp) {
      $scope.comment = val;
      NotifSrv.success();
    });
  }

}]);
