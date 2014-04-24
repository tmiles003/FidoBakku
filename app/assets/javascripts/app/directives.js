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

fiApp.directive('gravatar', [function() {
  return {
    restrict: 'E',
    link: function(scope, element, attrs) { console.log(attrs);
      scope.$watch('attrs.hash', function(val) {
        var hash = val;
        var s = attrs.size;
        if (!s) {
          s = 25;
        }
        var d = !!attrs.d ? attrs.d : false;
        if (!d) {
          d = 'fidobakku'; // 'blank';
        }
        if ('fidobakku' == d) {
          var domain = 'd31q9n9jefsa5o.cloudfront.net';
          d = 'https://'+ domain +'/images/fidobakku-'+ s +'x'+ s +'.png';
        } 
        var tag = '<img alt="" src="https://secure.gravatar.com/avatar/' + hash + '?s=' + s + '&d=' + d + '">';
        element.replaceWith(tag);
      });
    }
  }
}]);
