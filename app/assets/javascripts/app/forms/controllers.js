'use strict';

/* Controllers */

fiApp.controller('FormCtrl', ['$scope', 'FormSrv', function($scope, Form) {
  
  $scope.forms = Form.query();
  
  var createForm = function(newForm) {
    Form.save(newForm, 
      function(val, resp) {
        $scope.forms = Form.query(); // can i do this better?
        $scope.editableForm = {};
        $scope.editableFormForm.$setPristine();
      }, 
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit...
      });
  }
  
  var updateForm = function(form) {
    form.$update(function(val, resp) {
      $scope.forms = Form.query();
      $scope.editableForm = {};
      $scope.editableFormForm.$setPristine();
    });
  }
  
  $scope.saveForm = function(form) {
    $scope.errorName = null;
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
