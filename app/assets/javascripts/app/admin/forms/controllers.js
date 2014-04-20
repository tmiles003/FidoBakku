'use strict';

/* Controllers */

fiApp.controller('FormsAdminCtrl', ['$scope', '$modal', 
                 'FormsAdminSrv', 'NotifSrv', 'forms', 
                  function($scope, $modal, 
                           FormsAdminSrv, NotifSrv, forms) {
  
  $scope.forms = forms; // resolved in route definition
  
  var createForm = function(newForm) {
    FormsAdminSrv.save(newForm, function(val, resp) {
      $scope.forms.push(val);
      $scope.eForm = {};
      $scope.eFormForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateForm = function(form) {
    FormsAdminSrv.update(form, function(val, resp) {
      var form = _.find($scope.forms, function(f) {
        return f.id === val.id;
      });
      _.extend(form, val); // update object with returned values
      $scope.eForm = {};
      $scope.eFormForm.$setPristine();
      NotifSrv.success();
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
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eForm = {};
    $scope.eFormForm.$setPristine();
  }
  
  $scope.editForm = function(form) {
    $scope.eForm = angular.copy(form);
  }
  
  $scope.deleteConfirm = function(form) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/forms/form-delete.html',
        controller: deleteFormCtrl,
        resolve: {
          form: function() { return form; }
        }
      })
      .result.then(function(form) {
        deleteForm(form);
      });
  }
  
  var deleteFormCtrl = function($scope, $modalInstance, form) {
    $scope.form = form;
    $scope.delete = function() {
      $modalInstance.close($scope.form);
    }
  }
  
  var deleteForm = function(form) {
    form.$delete(function() {
      $scope.forms = _.without($scope.forms, form);
      NotifSrv.success();
    });
  }
  
}]);
