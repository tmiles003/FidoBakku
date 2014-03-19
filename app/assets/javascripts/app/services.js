'use strict';

/* Services */

fiApp.factory('NotifSrv', ['toaster', function (toaster) {
  
  var service = {
    
    success: function(title, text, timeout) {
      timeout = timeout || 500;
      toaster.pop('success', title, text, timeout);
    },
    
    info: function(title, text, timeout) {
      timeout = timeout || 10000;
      toaster.pop('info', title, text, timeout);
    },
    
    error: function(title, text, timeout) {
      timeout = timeout || 10000;
      toaster.pop('error', title, text, timeout);
    }
    
  };
  
  return service;
}]);
