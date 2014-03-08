'use strict';

/* Controllers */

var FormSectionCtrl = angular.module('fiFormSectionController', []);

FormSectionCtrl.controller('FormSectionCtrl', ['$scope', 'FormSection', function($scope, Section) {
  
  $scope.formId = angular.element('#form_id').val();
  $scope.sections = Section.query({ form_id: $scope.formId });
  
  var createSection = function(newSection) {
    Section.save({ form_id: $scope.formId, form_section: newSection },
      function(val, resp) {
        $scope.sections.push(val); console.log( $scope.sections );
        $scope.editableSection = {};
        $scope.editableSectionForm.$setPristine();
      },
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateSection = function(section) {
    section.$update(function(val, resp) {
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
    section.$delete().then(function() {
      $scope.sections = _.without($scope.sections, section);
    });
  }
  
}]);
