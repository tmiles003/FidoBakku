
fiApp.controller('FormUserAdminCtrl', ['$scope', 
                  'FormUserAdminSrv', 'NotifSrv',
                  function($scope,
                           FormUserAdminSrv, NotifSrv) {
  
  $scope.formId = $scope.$parent.form.id;
  $scope.teams = $scope.$parent.form.teams;
  $scope.form_users = $scope.$parent.form.form_users;
  
  $scope.updateAssignment = function(form_user) {
    form_user.form_id = form_user.assigned ? null : $scope.formId;
    FormUserAdminSrv.update(form_user, function(val) {
      NotifSrv.success();
    });
  }
  
}]);
