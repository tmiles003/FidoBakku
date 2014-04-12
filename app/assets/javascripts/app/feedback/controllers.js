'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', '$http', 
                 'FeedbackSrv', 'feedback', 'NotifSrv', 
                  function($scope, $http, 
                           FeedbackSrv, feedback, NotifSrv) {
  
  $scope.feedback = feedback;
  
  $scope.forms = [];
  $http.get('/api/form', { params: { form_id: feedback.form_id } })
    .success(function(forms) {
      $scope.forms = forms;
    });

}]);
