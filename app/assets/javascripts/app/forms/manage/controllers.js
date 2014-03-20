'use strict';

/* Controllers */

fiApp.controller('TopicsCtrl', ['$scope', 'TopicsSrv', 'NotifSrv', '$routeParams', '$filter', 
                  function($scope, Topics, NotifSrv, $routeParams, $filter) {
  
  $scope.formId = $routeParams.id;
  $scope.topics = Topics.query({ form_id: $scope.formId });
  $scope.submitted = false;
  
  var createTopic = function(newTopic) {
    Topics.save({ form_id: $scope.formId, topic: newTopic }, function(val, resp) {
      $scope.topics.push(val);
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
      NotifSrv.success();
    },
    function(resp) {
      NotifSrv.error('Error'); // improve
      // $scope.errorName = resp.data.name[0]; // clean this up a bit
    });
  }
  
  var updateTopic = function(topic) {
    topic.$update({ form_id: $scope.formId }, function(val, resp) {
      $scope.topics = Topics.query({ form_id: $scope.formId }); // improve
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
  $scope.saveTopic = function(topic, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      if (topic.id) {
        updateTopic(topic);
      }
      else {
        createTopic(topic);
      }
    }
    else {
      // NotifSrv.error('Error');
    }
  }
  
  $scope.moveTopicUp = function(topic) {
    Topics.up({ id: topic.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var topic = _.find($scope.topics, function(t) {
          return t.id === el.id;
        });
        topic.ordr = el.ordr; // update object in array
      });
      // reorder topics
      $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      NotifSrv.success();
    }, 
    function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
  $scope.moveTopicDown = function(topic) {
    Topics.down({ id: topic.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var topic = _.find($scope.topics, function(t) {
          return t.id === el.id;
        });
        topic.ordr = el.ordr; // update object in array
      });
      // reorder topics
      $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      NotifSrv.success();
    }, 
    function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
  $scope.editTopic = function(topic) {
    $scope.editableTopic = angular.copy(topic);
  }
  
  $scope.deleteTopic = function(topic) {
    topic.$delete({ form_id: $scope.formId }).then(function() {
      $scope.topics = _.without($scope.topics, topic);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);

fiApp.controller('BenchmarksCtrl', ['$scope', 'BenchmarksSrv', 'NotifSrv', '$filter', 
                  function($scope, Benchmarks, NotifSrv, $filter) {
  
  $scope.topicId = $scope.$parent.topic.id;
  $scope.benchmarks = Benchmarks.query({ topic_id: $scope.topicId });
  $scope.submitted = false;
  
  var createBenchmark = function(newBenchmark) {
    Benchmarks.save({ topic_id: $scope.topicId, benchmark: newBenchmark }, function(val, resp) {
      $scope.benchmarks.push(val);
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
      NotifSrv.success();
    },
    function(resp) {
      NotifSrv.error('Error'); // improve
      // $scope.errorName = resp.data.name[0]; // clean this up a bit
    });
  }
  
  var updateBenchmark = function(benchmark) {
    benchmark.$update(function(val, resp) {
      $scope.benchmarks = Benchmarks.query({ topic_id: $scope.topicId }); // improve
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
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
    else {
      // NotifSrv.error('Error');
    }
  }
  
  $scope.moveBenchmarkUp = function(benchmark) {
    Benchmarks.up({ id: benchmark.id },
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
      }, 
      function(resp) {
        NotifSrv.error('Error'); // improve
      });
  }
  
  $scope.moveBenchmarkDown = function(benchmark) {
    Benchmarks.down({ id: benchmark.id },
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
      }, 
      function(resp) {
        NotifSrv.error('Error'); // improve
      });
  }
  
  $scope.editBenchmark = function(benchmark) {
    $scope.editableBenchmark = angular.copy(benchmark);
  }
  
  $scope.deleteBenchmark = function(benchmark) {
    benchmark.$delete().then(function() {
      $scope.benchmarks = _.without($scope.benchmarks, benchmark);
      NotifSrv.success();
    }, function(resp) {
      NotifSrv.error('Error'); // improve
    });
  }
  
}]);
