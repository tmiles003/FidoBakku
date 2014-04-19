'use strict';

/* Controllers */

fiApp.controller('FormSectionsAdminCtrl', ['$scope', '$filter', '$modal',
                  'form', 'FormSectionsAdminSrv', 'FormPartAdminSrv', 'NotifSrv', 
                  function($scope, $filter, $modal,
                           form, FormSectionsAdminSrv, FormPartAdminSrv, NotifSrv) {
  
  $scope.form = form;
  $scope.form_part = new FormPartAdminSrv(form.form_part);
  $scope.sections = form.form_sections;
  
  $scope.eSection = {};
  $scope.submitted = false;
  
  // save part_id when changed
  $scope.$watch('form_part.part_id', function(newVal, oldVal) {
    if (newVal !== oldVal) {
      $scope.form_part.$update(function() {
        NotifSrv.success();
      });
    }
  });
  
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
  
  $scope.deleteConfirm = function(section) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/forms/section-delete.html',
        controller: deleteSectionCtrl,
        resolve: {
          section: function() { return section; }
        }
      })
      .result.then(function(section) {
        deleteSection(section);
      });
  }
  
  var deleteSectionCtrl = function($scope, $modalInstance, section) {
    $scope.section = section;
    $scope.delete = function() {
      $modalInstance.close($scope.section);
    }
  }
  
  var deleteSection = function(section) {
    $scope.submitted = false;
    $scope.eSection = {};
    $scope.eSectionForm.$setPristine();
    FormSectionsAdminSrv.delete({ id: section.id }, function() {
      $scope.sections = _.without($scope.sections, section);
      NotifSrv.success();
    });
  }
  
}]);

fiApp.controller('FormCompsAdminCtrl', ['$scope', '$modal', '$filter', 
                 'FormCompsAdminSrv', 'NotifSrv', 
                  function($scope, $modal, $filter, 
                           FormCompsAdminSrv, NotifSrv) {
  
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
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eComp = {};
    $scope.eCompForm.$setPristine();
  }
  
  $scope.deleteConfirm = function(comp) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/admin/forms/comp-delete.html',
        controller: deleteCompCtrl,
        resolve: {
          comp: function() { return comp; }
        }
      })
      .result.then(function(comp) {
        deleteComp(comp);
      });
  }
  
  var deleteCompCtrl = function($scope, $modalInstance, comp) {
    $scope.comp = comp;
    $scope.delete = function() {
      $modalInstance.close($scope.comp);
    }
  }
  
  var deleteComp = function(comp) {
    $scope.submitted = false;
    $scope.eComp = {};
    $scope.eCompForm.$setPristine();
    comp.$delete(function() {
      $scope.comps = _.without($scope.comps, comp);
      NotifSrv.success();
    });
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
