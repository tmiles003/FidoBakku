'use strict';

/* Controllers */

fiApp.controller('EvaluationLoopsAdminCtrl', ['$scope', '$modal', 
                 'EvaluationLoopsAdminSrv', 'NotifSrv', 'loops',
                  function($scope, $modal, 
                           EvaluationLoopsAdminSrv, NotifSrv, loops) {
  
  $scope.loops = loops;
  
  var createLoop = function(newLoop) {
    EvaluationLoopsAdminSrv.save(newLoop, function(val, resp) {
      $scope.loops.push(val);
      $scope.eLoop = {};
      $scope.eLoopForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateLoop = function(loop) {
    loop.$update(function(val, resp) {
      var loop = _.find($scope.loops, function(s) {
        return s.id === val.id;
      });
      _.extend(loop, val); // update object with returned values
      $scope.eLoop = {};
      $scope.eLoopForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveLoop = function(loop, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (loop.id) {
        updateLoop(loop);
      }
      else {
        createLoop(loop);
      }
    }
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eLoop = {};
    $scope.eLoopForm.$setPristine();
  }
  
  $scope.editLoop = function(loop) {
    $scope.eLoop = angular.copy(loop);
    jQuery('input[name="loop_title"]').first().focus();
  }
  
  $scope.deleteConfirm = function(loop) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/evaluations/loop-delete.html',
        controller: deleteLoopCtrl,
        resolve: { 
          loop: function() { return loop; }
        }
      })
      .result.then(function(loop) {
        deleteLoop(loop);
      });
  };
  
  var deleteLoopCtrl = function($scope, $modalInstance, loop) {
    $scope.loop = loop;
    $scope.delete = function() {
      $modalInstance.close($scope.loop);
    }
  }
  
  var deleteLoop = function(loop) {
    $scope.submitted = false;
    $scope.eLoop = {};
    $scope.eLoopForm.$setPristine();
    EvaluationLoopsAdminSrv.delete({ id: loop.id }, function() {
      $scope.loops = _.without($scope.loops, loop);
      NotifSrv.success();
    });
  }
  
}]);
