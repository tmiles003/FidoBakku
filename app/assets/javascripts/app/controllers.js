'use strict';

/* Controllers */

angular.module('fbApp.controllers', [])

  .controller('GreetingCtrl', ['$scope', function($scope) {
    // $scope.greeting = 'Hola!';
  }])
  
  .controller('UserFormCtrl', ['$scope', 'UserService', '$sce', 
                function($scope, UserService, $sce) {
    
    $scope.createUser = function(formData) {
      UserService.createUser(formData).then(function(res) {
        $scope.formData = {};
        $scope.newUserForm.$setPristine();
      });
    }
    
  }])
  
  .controller('UserListCtrl', ['$scope', 'UserService', 
                function($scope, UserService) {
    UserService.getUserList().then(function(res) {
      $scope.userList = res.data;
    });
  }])
;
