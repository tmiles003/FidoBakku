
fiApp.controller('FormUserAdminCtrl', ['$scope', 
                  'TeamsAdminSrv', 'FormUserAdminSrv', 'NotifSrv',
                  function($scope,
                           TeamsAdminSrv, FormUserAdminSrv, NotifSrv) {
  
  $scope.formId = $scope.$parent.form.id;
  
  $scope.teams = [];
  TeamsAdminSrv.query(function(teams) {
    $scope.teams = teams;
  });
  
  $scope.form_users = [];
  FormUserAdminSrv.query({ form_id: $scope.formId }, function(form_users) {
    $scope.form_users = form_users;
  });
  
  $scope.updateAssignment = function(form_user) {
    form_user.form_id = form_user.assigned ? null : $scope.formId;
    form_user.$update(function(val) {
      NotifSrv.success();
    });
  }
  
}]);
