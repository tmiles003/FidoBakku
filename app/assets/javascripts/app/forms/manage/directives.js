'use strict';

/* Directives */

fiApp.directive('formUser', [function() {
  return {
    restrict: 'A',
    scope: {
      user: '='
    },
    link: function(scope, element, attrs, controller) {
      // console.log( scope.user.name );
      // element.addClass('btn-primary');
    }
  };
}]);
