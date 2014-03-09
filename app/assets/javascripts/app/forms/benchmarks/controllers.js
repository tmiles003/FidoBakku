'use strict';

/* Controllers */

var SectionBenchmarkCtrl = angular.module('fiSectionBenchmarkController', []);

SectionBenchmarkCtrl.controller('SectionBenchmarkCtrl', ['$scope', 'SectionBenchmark', function($scope, Benchmark) {
  
  // $scope.formId = angular.element('#form_id').val();
  // $scope.benchmarks = Benchmark.query({ form_id: $scope.formId });
  console.log( $scope.$parent );
  console.log( $scope.$parent.formId );
  
  /* var createSection = function(newSection) {
    Section.save({ form_id: $scope.formId, form_section: newSection },
      function(val, resp) {
        $scope.sections.push(val);
        $scope.editableSection = {};
        $scope.editableSectionForm.$setPristine();
      },
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateSection = function(section) {
    section.$update(function(val, resp) { // { form_id: $scope.formId },
      $scope.sections = Section.query();
      $scope.editableSection = {};
      $scope.editableSectionForm.$setPristine();
    });
  }
  
  $scope.saveSection = function(section) {
    $scope.errorName = null;
    if (section.id) {
      updateSection(section);
    }
    else {
      createSection(section);
    }
  }
  
  $scope.editSection = function(section) {
    $scope.editableSection = angular.copy(section);
  }
  
  $scope.deleteSection = function(section) {
    section.$delete({ form_id: $scope.formId }).then(function() {
      $scope.sections = _.without($scope.sections, section);
    });
  } */
  
}]);
