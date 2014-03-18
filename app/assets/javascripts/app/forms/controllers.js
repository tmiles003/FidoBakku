'use strict';

/* Controllers */

fiApp.controller('FormsCtrl', ['$scope', 'FormsSrv', function($scope, Forms) {
  
  $scope.forms = Forms.query();
  
  var createForm = function(newForm) {
    Forms.save(newForm, 
      function(val, resp) {
        $scope.forms = Forms.query(); // can i do this better?
        $scope.editableForm = {};
        $scope.editableFormForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateForm = function(form) {
    form.$update(function(val, resp) {
      $scope.forms = Forms.query();
      $scope.editableForm = {};
      $scope.editableFormForm.$setPristine();
    });
  }
  
  $scope.saveForm = function(form, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (form.id) {
        updateForm(form);
      }
      else {
        createForm(form);
      }
    }
    else {
      // console.log('form has errors');
    }
  }
  
  $scope.editForm = function(form) {
    $scope.editableForm = angular.copy(form);
  }
  
  $scope.deleteForm = function(form) {
    form.$delete().then(function() {
      $scope.forms = _.without($scope.forms, form);
    });
  }
  
}]);
