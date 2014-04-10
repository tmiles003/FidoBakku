'use strict';

/* Controllers */

fiApp.controller('UserEvaluationCtrl', ['$scope', '$http', '$routeParams', 
                 'UserEvaluationSrv', 'evaluation', 'NotifSrv', 
                  function($scope, $http, $routeParams, 
                           UserEvaluationSrv, evaluation, NotifSrv) {
  
  $scope.evaluation = evaluation;
  $scope.scores = angular.fromJson(evaluation.scores);

  /* var isLoading = true;
  $scope.$watchCollection('scores', function() { // console.log( $scope.evaluation );
    UserEvaluationSrv.update({ id: $scope.evaluation.id },
      { scores: JSON.stringify($scope.scores) }, function() {
        if (!isLoading) 
          NotifSrv.success();
        else 
          isLoading = false;
      });
  }); */
}]);
