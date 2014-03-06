'use strict';

/* Controllers */

// var fiAppCtrl = angular.module('fiApp.controllers');

fiApp.controller('UsersCtrl', ['$scope', 'UserService', function($scope, UserService) {
  
  UserService.query({}, function(res) {
    $scope.users = res;
  });
  
  $scope.createUser = function(formData) {
    UserService.save(formData, 
      function(val) {
        $scope.formData = {};
        $scope.newUserForm.$setPristine();
        /* UserService.query({}, function(res) {
          $scope.users = res;
        }); */
      }, 
      function(resp) {
        console.log( resp );
      }
    );
  }
  
  $scope.deleteUser = function(id) {
    UserService.delete({}, { id: id }, 
      function(val) {
        console.log( val );
      },
      function(resp) {
        console.log( resp );
      }
    );
  }
  
}]);
