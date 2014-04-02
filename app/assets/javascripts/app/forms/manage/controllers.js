'use strict';

/* Controllers */

fiApp.controller('SectionsCtrl', ['$scope', '$http', '$routeParams', '$filter', 
                  'SectionsSrv', 'sections', 'NotifSrv', 
                  function($scope, $http, $routeParams, $filter, 
                           SectionsSrv, sections, NotifSrv) {
  
  $scope.formId = $routeParams.id;
  $scope.sections = sections;
  $scope.eSection = {};
  $scope.submitted = false;
  $http.get('/api/users/list').success(function(list) { 
    $scope.users = list; 
  });
  
  var createSection = function(newSection) {
    SectionsSrv.save({ form_id: $scope.formId, section: newSection }, function(val, resp) {
      $scope.sections.push(val);
      $scope.eSection = {};
      $scope.eSectionForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateSection = function(section) {
    section.$update({ form_id: $scope.formId }, function(val, resp) {
      var section = _.find($scope.sections, function(t) {
        return t.id === val.id;
      });
      _.extend(section, val); // update object with returned values
      $scope.eSection = {};
      $scope.eSectionForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveSection = function(section, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (section.id) {
        updateSection(section);
      }
      else {
        createSection(section);
      }
    }
  }
  
  $scope.moveSectionUp = function(section) {
    SectionsSrv.up({ id: section.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var section = _.find($scope.sections, function(s) {
          return s.id === el.id;
        });
        // _.extend     
        section.ordr = el.ordr; // update object in array
      });
      // reorder sections
      $scope.sections = $filter('orderBy')($scope.sections, '+ordr');
      NotifSrv.success();
    });
  }
  
  $scope.moveSectionDown = function(section) {
    SectionsSrv.down({ id: section.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var section = _.find($scope.sections, function(s) {
          return s.id === el.id;
        });
        section.ordr = el.ordr; // update object in array
      });
      // reorder sections
      $scope.sections = $filter('orderBy')($scope.sections, '+ordr');
      NotifSrv.success();
    });
  }
  
  $scope.editSection = function(section) {
    $scope.eSection = angular.copy(section);
  }
  
  $scope.deleteSection = function(section) {
    section.$delete({ form_id: $scope.formId }).then(function() {
      $scope.sections = _.without($scope.sections, section);
      NotifSrv.success();
    });
  }
  
}]);

fiApp.controller('CompsCtrl', ['$scope', 'CompsSrv', 'NotifSrv', '$filter', 
                  function($scope, CompsSrv, NotifSrv, $filter) {
  
  $scope.sectionId = $scope.$parent.section.id;
  $scope.comps = CompsSrv.query({ section_id: $scope.sectionId });
  $scope.eComp = {};
  $scope.submitted = false;
  
  var createComp = function(newComp) {
    CompsSrv.save({ section_id: $scope.sectionId, comp: newComp }, function(val, resp) {
      $scope.comps.push(val);
      $scope.eComp = {};
      $scope.eCompForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateComp = function(comp) {
    comp.$update(function(val, resp) {
      var comp = _.find($scope.comps, function(b) {
        return b.id === val.id;
      });
      _.extend(comp, val); // update object with returned values
      $scope.eComp = {};
      $scope.eCompForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveComp = function(comp, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (comp.id) {
        updateComp(comp);
      }
      else {
        createComp(comp);
      }
    }
  }
  
  $scope.moveCompUp = function(comp) {
    CompsSrv.up({ id: comp.id },
      function(val, resp) { // success
        _.each(val, function(el) {
          var comp = _.find($scope.comps, function(c) {
            return c.id === el.id;
          });
          comp.ordr = el.ordr; // update object in array
        });
        // reorder comps
        $scope.comps = $filter('orderBy')($scope.comps, '+ordr');
        NotifSrv.success();
      });
  }
  
  $scope.moveCompDown = function(comp) {
    CompsSrv.down({ id: comp.id },
      function(val, resp) { // success
        _.each(val, function(el) {
          var comp = _.find($scope.comps, function(c) {
            return c.id === el.id;
          });
          comp.ordr = el.ordr; // update object in array
        });
        // reorder comps
        $scope.comps = $filter('orderBy')($scope.comps, '+ordr');
        NotifSrv.success();
      });
  }
  
  $scope.editComp = function(comp) {
    $scope.eComp = angular.copy(comp);
  }
  
  $scope.deleteComp = function(comp) {
    comp.$delete().then(function() {
      $scope.comps = _.without($scope.comps, comp);
      NotifSrv.success();
    });
  }
  
}]);

fiApp.controller('FormUserCtrl', ['$scope', '$http', '$routeParams',
                  'UsersSrv', 'FormUserSrv',
                  function($scope, $http, $routeParams, UsersSrv, FormUserSrv) {
  
  $scope.formId = $routeParams.id;
  $scope.roles = [];
  UsersSrv.getRoles(function(roles) {
    $scope.roles = roles;
  });
  
  $scope.updateFormAssignment = function(userId) {
    FormUserSrv.update({ id: $scope.formId, userId: userId }, function(val, resp) {
      console.log( val );
    });
  }
  
}]);
