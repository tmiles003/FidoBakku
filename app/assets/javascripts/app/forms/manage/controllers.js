'use strict';

/* Controllers */

fiApp.controller('TopicsCtrl', ['$scope', 'TopicsSrv', 'topics', 'NotifSrv', '$routeParams', '$filter', 
                  function($scope, TopicsSrv, topics, NotifSrv, $routeParams, $filter) {
  
  $scope.formId = $routeParams.id;
  $scope.topics = topics;
  $scope.editableTopic = {};
  $scope.submitted = false;
  
  var createTopic = function(newTopic) {
    TopicsSrv.save({ form_id: $scope.formId, topic: newTopic }, function(val, resp) {
      $scope.topics.push(val);
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  var updateTopic = function(topic) {
    topic.$update({ form_id: $scope.formId }, function(val, resp) {
      var topic = _.find($scope.topics, function(t) {
        return t.id === val.id;
      });
      _.extend(topic, val); // update object with returned values
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
      NotifSrv.success();
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
  }
  
  $scope.moveTopicUp = function(topic) {
    TopicsSrv.up({ id: topic.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var topic = _.find($scope.topics, function(t) {
          return t.id === el.id;
        });
        // _.extend     
        topic.ordr = el.ordr; // update object in array
      });
      // reorder topics
      $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      NotifSrv.success();
    });
  }
  
  $scope.moveTopicDown = function(topic) {
    TopicsSrv.down({ id: topic.id }, function(val, resp) { // success
      _.each(val, function(el) {
        var topic = _.find($scope.topics, function(t) {
          return t.id === el.id;
        });
        topic.ordr = el.ordr; // update object in array
      });
      // reorder topics
      $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      NotifSrv.success();
    });
  }
  
  $scope.editTopic = function(topic) {
    $scope.editableTopic = angular.copy(topic);
  }
  
  $scope.deleteTopic = function(topic) {
    topic.$delete({ form_id: $scope.formId }).then(function() {
      $scope.topics = _.without($scope.topics, topic);
      NotifSrv.success();
    });
  }
  
}]);

fiApp.controller('BenchmarksCtrl', ['$scope', 'BenchmarksSrv', 'NotifSrv', '$filter', 
                  function($scope, BenchmarksSrv, NotifSrv, $filter) {
  
  $scope.topicId = $scope.$parent.topic.id;
  $scope.benchmarks = BenchmarksSrv.query({ topic_id: $scope.topicId });
  $scope.editableBenchmark = {};
  $scope.submitted = false;
  
  var createBenchmark = function(newBenchmark) {
    BenchmarksSrv.save({ topic_id: $scope.topicId, benchmark: newBenchmark }, function(val, resp) {
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
