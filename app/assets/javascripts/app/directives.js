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
    link: function(scope, element, attrs) {
      scope.$watch(attrs.hash, function(val) {
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

fiApp.directive('fiProgress', [function() {
  return {
    // restrict: 'E',
    link: function(scope, element, attrs) {
      scope.$watch(attrs.angle, function(val) {
        var angle = val;
        var arc = d3.svg.arc()
          .innerRadius(8)
          .outerRadius(12)
          .startAngle(0)
          .endAngle(angle);
        var svg = d3.select(element[0]).append('svg')
          .attr('height', 24).attr('width', 24)
          .style('fill', '#415b76')
          .append('path')
          .attr('d', arc)
          .attr('transform', 'translate(12,12)');
      });
    }
  }
}]);
