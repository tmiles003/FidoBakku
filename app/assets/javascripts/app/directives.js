'use strict';

/* Directives */

fiApp.directive('activeNavLink', ['$location', function(location) {
  return {
    restrict: 'A',
    link: function(scope, element, attrs, controller) {
      var clas_ = attrs.activeNavLink;
      var path = attrs.href;
      path = path.substring(2); // fix this
      scope.location = location;
      scope.$watch('location.path()', function(newPath) {
        if (path === newPath) {
          element.addClass(clas_);
        } else {
          element.removeClass(clas_);
        }
      });
    }
  };
}]);
