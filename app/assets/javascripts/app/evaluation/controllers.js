'use strict';

/* Controllers */

fiApp.controller('UserEvaluationCtrl', ['$scope', '$http', '$routeParams', 
                 'UserEvaluationSrv', 'evaluation', 'FormsSrv', 'NotifSrv', 
                  function($scope, $http, $routeParams, 
                           UserEvaluationSrv, evaluation, FormsSrv, NotifSrv) {
  
  $scope.evaluation = evaluation;
  $scope.scores = angular.fromJson(evaluation.scores);
  
  $scope.forms = [];
  _.each(evaluation.form_ids, function(form_id) {
    $http.get('/api/user_evaluation_form', { params: { form_id: form_id } })
      .success(function(form) {
        $scope.forms.push(form);
      });
    
  });

  var isLoading = true;
  $scope.$watchCollection('scores', function() { // console.log( $scope.evaluation );
    UserEvaluationSrv.update({ id: $scope.evaluation.id },
      { scores: JSON.stringify($scope.scores) }, function() {
        if (!isLoading) 
          NotifSrv.success();
        else 
          isLoading = false;
      });
  });
}]);
