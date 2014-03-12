'use strict';

/* Controllers */

fiApp.controller('TopicCtrl', ['$scope', 'TopicSrv', '$routeParams', function($scope, Topic, $routeParams) {
  
  $scope.formId = $routeParams.id;
  $scope.topics = Topic.query({ form_id: $scope.formId });
  
  var createTopic = function(newTopic) {
    Topic.save({ form_id: $scope.formId, topic: newTopic },
      function(val, resp) {
        $scope.topics.push(val);
        $scope.editableTopic = {};
        $scope.editableTopicForm.$setPristine();
      },
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateTopic = function(topic) {
    topic.$update(function(val, resp) { // { form_id: $scope.formId },
      $scope.topics = Topic.query({ form_id: $scope.formId });
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
    });
  }
  
  $scope.saveTopic = function(topic) {
    $scope.errorName = null;
    if (topic.id) {
      updateTopic(topic);
    }
    else {
      createTopic(topic);
    }
  }
  
  $scope.editTopic = function(topic) {
    $scope.editableTopic = angular.copy(topic);
  }
  
  $scope.deleteTopic = function(topic) {
    topic.$delete({ form_id: $scope.formId }).then(function() {
      $scope.topics = _.without($scope.topics, topic);
    });
  }
  
}]);

fiApp.controller('BenchmarkCtrl', ['$scope', 'BenchmarkSrv', function($scope, Benchmark) {
  
  // $scope.formId = $scope.$parent.formId;
  $scope.topicId = $scope.$parent.topic.id;
  $scope.benchmarks = Benchmark.query({ topic_id: $scope.topicId });
  
  var createBenchmark = function(newBenchmark) {
    Benchmark.save({ topic_id: $scope.topicId, benchmark: newBenchmark },
      function(val, resp) {
        $scope.benchmarks.push(val);
        $scope.editableBenchmark = {};
        $scope.editableBenchmarkForm.$setPristine();
      },
      function(resp) {
        $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateBenchmark = function(benchmark) {
    benchmark.$update(function(val, resp) {
      $scope.benchmarks = Benchmark.query({ topic_id: $scope.topicId });
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
    });
  }
  
  $scope.saveBenchmark = function(benchmark) {
    $scope.errorName = null;
    if (benchmark.id) {
      updateBenchmark(benchmark);
    }
    else {
      createBenchmark(benchmark);
    }
  }
  
  $scope.editBenchmark = function(benchmark) {
    $scope.editableBenchmark = angular.copy(benchmark);
  }
  
  $scope.deleteBenchmark = function(benchmark) {
    benchmark.$delete().then(function() {
      $scope.benchmarks = _.without($scope.benchmarks, benchmark);
    });
  }
  
}]);
