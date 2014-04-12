'use strict';

/* Controllers */

fiApp.controller('UserEvaluationCtrl', ['$scope', '$http', 
                 'UserEvaluationSrv', 'userEvaluation', 'NotifSrv', 
                  function($scope, $http, 
                           UserEvaluationSrv, userEvaluation, NotifSrv) {
  
  $scope.userEvaluation = userEvaluation;
  $scope.ratings = angular.fromJson(userEvaluation.ratings);
  
  $scope.forms = [];
  $http.get('/api/form', { params: { form_id: userEvaluation.evaluation.form_id } })
    .success(function(forms) {
      $scope.forms = forms;
    });

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

}]);
