'use strict';

/* Controllers */

fiApp.controller('FeedbackCtrl', ['$scope', '$http', 
                 'FeedbackSrv', 'evaluation', 'NotifSrv', 
                  function($scope, $http, 
                           FeedbackSrv, evaluation, NotifSrv) {
  
  $scope.evaluation = evaluation;
  $scope.scores = angular.fromJson(evaluation.scores);
  
  $scope.forms = [];
  _.each(evaluation.form_ids, function(form_id) {
    $http.get('/api/feedback/form', { params: { form_id: form_id } })
      .success(function(form) {
        $scope.forms.push(form);
      });
  });
  // re-order forms correctly

}]);
