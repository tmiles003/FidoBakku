'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', 
                 'FeedbackSrv', 'feedback', 'CommentsSrv', 'NotifSrv', 
                  function($scope, 
                           FeedbackSrv, feedback, CommentsSrv, NotifSrv) {
  
  $scope.feedback = feedback;
  $scope.form_parts = feedback.form_parts;
  $scope.eComment = $scope.feedback.comment;
  
  $scope.saveComment = function(eComment) {
    CommentsSrv.update(comment, function(val, resp) {
      $scope.eComment = val;
      NotifSrv.success();
    });
  }

}]);
