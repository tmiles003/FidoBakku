'use strict';

angular.module('ui-bootstrap-tpls', [
  'template/datepicker/popup.html',
  'template/tooltip/tooltip-popup.html',
  'template/datepicker/datepicker.html',
  'template/modal/backdrop.html',
  'template/modal/window.html'
]);

angular.module('template/datepicker/popup.html', [])
  .run(['$templateCache', '$http', function($templateCache, $http) {
    $templateCache.put('template/datepicker/popup.html', 
      $http.get('/templates/ui-bootstrap/datepicker/popup.html'));
  }]);

angular.module('template/tooltip/tooltip-popup.html', [])
  .run(['$templateCache', '$http', function($templateCache, $http) {
    $templateCache.put('template/tooltip/tooltip-popup.html', 
      $http.get('/templates/ui-bootstrap/tooltip/tooltip-popup.html'));
  }]);

angular.module('template/datepicker/datepicker.html', [])
  .run(['$templateCache', '$http', function($templateCache, $http) {
    $templateCache.put('template/datepicker/datepicker.html', 
      $http.get('/templates/ui-bootstrap/datepicker/datepicker.html'));
  }]);

angular.module('template/modal/backdrop.html', [])
  .run(['$templateCache', '$http', function($templateCache, $http) {
    $templateCache.put('template/modal/backdrop.html', 
      $http.get('/templates/ui-bootstrap/modal/backdrop.html'));
  }]);

angular.module('template/modal/window.html', [])
  .run(['$templateCache', '$http', function($templateCache, $http) {
    $templateCache.put('template/modal/window.html', 
      $http.get('/templates/ui-bootstrap/modal/window.html'));
  }]);
