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
        var section = _.find($scope.sections, function(t) {
          return t.id === el.id;
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
        var section = _.find($scope.sections, function(t) {
          return t.id === el.id;
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

fiApp.controller('BenchmarksCtrl', ['$scope', 'BenchmarksSrv', 'NotifSrv', '$filter', 
                  function($scope, BenchmarksSrv, NotifSrv, $filter) {
  
  $scope.sectionId = $scope.$parent.section.id;
  $scope.benchmarks = BenchmarksSrv.query({ section_id: $scope.sectionId });
  $scope.editableBenchmark = {};
  $scope.submitted = false;
  
  var createBenchmark = function(newBenchmark) {
    BenchmarksSrv.save({ section_id: $scope.sectionId, benchmark: newBenchmark }, function(val, resp) {
      $scope.benchmarks.push(val);
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateBenchmark = function(benchmark) {
    benchmark.$update(function(val, resp) {
      var benchmark = _.find($scope.benchmarks, function(b) {
        return b.id === val.id;
      });
      _.extend(benchmark, val); // update object with returned values
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.saveBenchmark = function(benchmark, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (benchmark.id) {
        updateBenchmark(benchmark);
      }
      else {
        createBenchmark(benchmark);
      }
    }
  }
  
  $scope.moveBenchmarkUp = function(benchmark) {
    BenchmarksSrv.up({ id: benchmark.id },
      function(val, resp) { // success
        _.each(val, function(el) {
          var benchmark = _.find($scope.benchmarks, function(b) {
            return b.id === el.id;
          });
          benchmark.ordr = el.ordr; // update object in array
        });
        // reorder benchmarks
        $scope.benchmarks = $filter('orderBy')($scope.benchmarks, '+ordr');
        NotifSrv.success();
      });
  }
  
  $scope.moveBenchmarkDown = function(benchmark) {
    BenchmarksSrv.down({ id: benchmark.id },
      function(val, resp) { // success
        _.each(val, function(el) {
          var benchmark = _.find($scope.benchmarks, function(b) {
            return b.id === el.id;
          });
          benchmark.ordr = el.ordr; // update object in array
        });
        // reorder benchmarks
        $scope.benchmarks = $filter('orderBy')($scope.benchmarks, '+ordr');
        NotifSrv.success();
      });
  }
  
  $scope.editBenchmark = function(benchmark) {
    $scope.editableBenchmark = angular.copy(benchmark);
  }
  
  $scope.deleteBenchmark = function(benchmark) {
    benchmark.$delete().then(function() {
      $scope.benchmarks = _.without($scope.benchmarks, benchmark);
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
