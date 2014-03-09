'use strict';

/* Controllers */

var SectionBenchmarkCtrl = angular.module('fiSectionBenchmarkController', []);

SectionBenchmarkCtrl.controller('SectionBenchmarkCtrl', ['$scope', 'SectionBenchmark', function($scope, Benchmark) {
  
  $scope.formId = $scope.$parent.formId;
  $scope.sectionId = $scope.$parent.section.id;
  $scope.benchmarks = Benchmark.query({ form_id: $scope.formId, section_id: $scope.sectionId });
  
  var createBenchmark = function(newBenchmark) {
    Benchmark.save({ form_id: $scope.formId, section_id: $scope.sectionId, section_benchmark: newBenchmark },
      function(val, resp) {
        $scope.benchmarks.push(val);
        $scope.editableBenchmark = {};
        $scope.editableBenchmarkForm.$setPristine();
      },
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateBenchmark = function(benchmark) {
    benchmark.$update({ form_id: $scope.formId, section_id: $scope.sectionId }, function(val, resp) {
      $scope.benchmarks = Benchmark.query({ form_id: $scope.formId, section_id: $scope.sectionId });
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
    });
  }
  
  $scope.saveBenchmark = function(benchmark) {
    $scope.errorName = null;
    if (benchmark.id) {
      updateBenchmark(benchmark);
    }
    else {
      createBenchmark(benchmark);
    }
  }
  
  $scope.editBenchmark = function(benchmark) {
    $scope.editableBenchmark = angular.copy(benchmark);
  }
  
  $scope.deleteBenchmark = function(benchmark) {
    benchmark.$delete({ form_id: $scope.formId, section_id: $scope.sectionId }).then(function() {
      $scope.benchmarks = _.without($scope.benchmarks, benchmark);
    });
  }
  
}]);
