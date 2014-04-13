'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', '$http', 
                 'FeedbackSrv', 'feedback', 'CommentsSrv', 'NotifSrv', 
                  function($scope, $http, 
                           FeedbackSrv, feedback, CommentsSrv, NotifSrv) {
  
  $scope.feedback = feedback;
  
  $scope.forms = [];
  $http.get('/api/form', { params: { form_id: feedback.form_id } })
    .success(function(forms) {
      $scope.forms = forms;
    });
  
  $scope.eComment = feedback.comment;
  $scope.saveComment = function(eComment) {
    CommentsSrv.update({ id: eComment.id, comment: eComment }, function(val, resp) {
      $scope.eComment = val;
      NotifSrv.success();
    });
  }

}]);
