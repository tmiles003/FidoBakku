'use strict';

/* Controllers */

fiApp.controller('FormSectionsAdminCtrl', ['$scope', '$filter', 
                  'form', 'FormSectionsAdminSrv', 'sections', 'NotifSrv', 
                  function($scope, $filter, 
                           form, FormSectionsAdminSrv, sections, NotifSrv) {
  
  $scope.form = form;
  $scope.sections = sections;
  
  $scope.eSection = {};
  $scope.submitted = false;
  
  var createSection = function(newSection) {
    FormSectionsAdminSrv.save({ form_id: $scope.form.id, form_section: newSection }, function(val, resp) {
      $scope.sections.push(val);
      $scope.eSection = {};
      $scope.eSectionForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateSection = function(section) {
    section.$update({ form_id: $scope.form.id }, function(val, resp) {
      var section = _.find($scope.sections, function(s) {
        return s.id === val.id;
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
    FormSectionsAdminSrv.up({ id: section.id }, function(val, resp) { // success
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
    FormSectionsAdminSrv.down({ id: section.id }, function(val, resp) { // success
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
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eSection = {};
    $scope.eSectionForm.$setPristine();
  }
  
  $scope.deleteSection = function(section) {
    section.$delete({ form_id: $scope.form.id }).then(function() {
      $scope.sections = _.without($scope.sections, section);
      NotifSrv.success();
    });
  }
  
}]);

fiApp.controller('FormCompsAdminCtrl', ['$scope', 'FormCompsAdminSrv', 'NotifSrv', '$filter', 
                  function($scope, FormCompsAdminSrv, NotifSrv, $filter) {
  
  $scope.sectionId = $scope.$parent.section.id;
  $scope.comps = FormCompsAdminSrv.query({ section_id: $scope.sectionId });
  $scope.eComp = {};
  $scope.submitted = false;
  
  var createComp = function(newComp) {
    FormCompsAdminSrv.save({ section_id: $scope.sectionId, form_comp: newComp }, function(val, resp) {
      $scope.comps.push(val);
      $scope.eComp = {};
      $scope.eCompForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateComp = function(comp) {
    comp.$update(function(val, resp) {
      var comp = _.find($scope.comps, function(c) {
        return c.id === val.id;
      });
      _.extend(comp, val); // update object with returned values
      $scope.eComp = {};
      $scope.eCompForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.logThis = function(t) {
    console.log(t);
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
    FormCompsAdminSrv.up({ id: comp.id },
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
    FormCompsAdminSrv.down({ id: comp.id },
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

fiApp.controller('FormPartAdminCtrl', ['$scope', '$routeParams', '$http', 'FormPartAdminSrv', 'NotifSrv',
                  function($scope, $routeParams, $http, FormPartAdminSrv, NotifSrv) {
  
  var formId = $routeParams.id;
  $scope.sharedForms = [];
  $http.get('/api/admin/forms?shared=1').success(function(sharedForms) {
    $scope.sharedForms = sharedForms;
  });
  $scope.sharedForm = {};
  FormPartAdminSrv.query({ form_id: formId }, function(sharedForm) { 
    $scope.sharedForm = sharedForm;
  });
  
  var createShared = function(newShared) {
    FormPartAdminSrv.save({ form_id: formId, form_part: newShared }, function(val, resp) {
      $scope.sharedForm = val;
      NotifSrv.success();
    });
  }
  
  var updateShared = function(shared) {
    shared.$update(function(val, resp) {
      $scope.sharedForm = val;
      NotifSrv.success();
    });
  }
  
  var deleteShared = function(shared) {
    shared.$delete().then(function(val) {
      $scope.sharedForm = val;
      NotifSrv.success();
    });
  }
  
  $scope.saveShared = function(shared) {
    if (shared.id) {
      if (shared.part_id)
        updateShared(shared);
      else
        deleteShared(shared);
    }
    else {
      if (shared.part_id)
        createShared(shared);
    }
  }
  
}]);

fiApp.controller('FormUserAdminCtrl', ['$scope', 
                  'TeamsAdminSrv', 'FormUserAdminSrv', 'NotifSrv',
                  function($scope,
                           TeamsAdminSrv, FormUserAdminSrv, NotifSrv) {
  
  $scope.formId = $scope.$parent.form.id;
  
  $scope.teams = [];
  TeamsAdminSrv.query(function(teams) {
    $scope.teams = teams;
  });
  
  $scope.users = [];
  FormUserAdminSrv.users({ id: $scope.formId }, function(users) {
    $scope.users = users;
  });
  
  $scope.assign = function(id) {
    FormUserAdminSrv.assign({ id: $scope.formId, userId: id }, function(val) {
      NotifSrv.success();
    });
  }
  
}]);
