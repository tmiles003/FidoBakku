'use strict';

/* Controllers */

var FormCtrl = angular.module('fiFormController', []);

FormCtrl.controller('FormCtrl', ['$scope', 'Form', function($scope, Form) {
  
  $scope.forms = Form.query();
  
  var createForm = function(newForm) {
    Form.save(newForm);
    $scope.forms = Form.query();
    // $scope.forms.push(Form.save(newForm));
    $scope.editableForm = {};
    $scope.editableFormForm.$setPristine();
  }
  
  var updateForm = function(form) {
    form.$update().then(function() {
      $scope.forms = Form.query();
      $scope.editableForm = {};
      $scope.editableFormForm.$setPristine();
    });
  }
  
  $scope.saveForm = function(form) {
    if (form.id) {
      updateForm(form);
    }
    else {
      createForm(form);
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
