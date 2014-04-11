'use strict';

/* Directives */

fiApp.directive('fiEvaluationUser', [function() {
  return {
    restrict: 'A',
    scope: {
      user: '=fiEvaluationUser'
    },
    link: function(scope, element, attrs, controller) {
      /* scope.$watch('user.form', function(newVal, oldVal) {
        if (newVal !== null)
          element.addClass('fi-form-user-sel');
        else
          element.removeClass('fi-form-user-sel');
      }); */
      
      /* element.on('$destroy', function() {
        // clean up
      }); */
    }
  };
}]);
