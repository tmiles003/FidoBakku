'use strict';

/* Controllers */

angular.module('fbApp.controllers', [])
  .controller('GreetingCtrl', ['$scope', function($scope) {
    $scope.greeting = 'Hola!';
  }])
;
