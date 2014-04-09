'use strict';

/* Directives */

fiApp.directive('fiFormUser', [function() {
  return {
    restrict: 'A',
    scope: {
      user: '=fiFormUser'
    },
    link: function(scope, element, attrs, controller) {
      scope.$watch('user.form', function(newVal, oldVal) {
        if (newVal !== null)
          element.addClass('fi-form-user-sel');
        else
          element.removeClass('fi-form-user-sel');
      });
      
      /* element.on('$destroy', function() {
        // clean up
      }); */
    }
  };
}]);
