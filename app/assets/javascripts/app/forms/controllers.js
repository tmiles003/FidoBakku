'use strict';

/* Controllers */

fiApp.controller('FormsCtrl', ['$scope', 'FormsSrv', 'NotifSrv', 'forms', 
                  function($scope, FormsSrv, NotifSrv, forms) {
  
  $scope.forms = forms; // Forms.query();
  
  var createForm = function(newForm) {
    FormsSrv.save(newForm, function(val, resp) {
      $scope.forms = FormsSrv.query(); // improve
      $scope.editableForm = {};
      $scope.editableFormForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
      // $scope.errorName = resp.data.name[0];
    });
  }
  
  var updateForm = function(form) {
    form.$update(function(val, resp) {
      $scope.forms = FormsSrv.query(); // improve
      $scope.editableForm = {};
      $scope.editableFormForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
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
      // NotifSrv.error('Error');
    }
  }
  
  $scope.editForm = function(form) {
    $scope.editableForm = angular.copy(form);
  }
  
  $scope.deleteForm = function(form) {
    form.$delete().then(function() {
      $scope.forms = _.without($scope.forms, form);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);
