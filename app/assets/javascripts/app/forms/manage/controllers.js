'use strict';

/* Controllers */

fiApp.controller('TopicsCtrl', ['$scope', 'TopicsSrv', '$routeParams', '$filter', 
                  function($scope, Topics, $routeParams, $filter) {
  
  $scope.formId = $routeParams.id;
  $scope.topics = Topics.query({ form_id: $scope.formId });
  $scope.submitted = false;
  
  var createTopic = function(newTopic) {
    Topics.save({ form_id: $scope.formId, topic: newTopic },
      function(val, resp) {
        $scope.topics.push(val);
        $scope.editableTopic = {};
        $scope.editableTopicForm.$setPristine();
      },
      function(resp) {
        // $scope.errorName = resp.data.name[0]; // clean this up a bit
      });
  }
  
  var updateTopic = function(topic) {
    topic.$update({ form_id: $scope.formId }, function(val, resp) {
      $scope.topics = Topics.query({ form_id: $scope.formId });
      $scope.editableTopic = {};
      $scope.editableTopicForm.$setPristine();
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
      // console.log('form not valid');
    }
  }
  
  $scope.moveTopicUp = function(topic) {
    Topics.up({ id: topic.id }, 
      function(val, resp) { // success
        _.each(val, function(el) {
          var topic = _.find($scope.topics, function(t) {
            return t.id === el.id;
          });
          topic.ordr = el.ordr; // update object in array
        });
        // reorder topics
        $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      }, 
      function(resp) {
        // error
      });
  }
  
  $scope.moveTopicDown = function(topic) {
    Topics.down({ id: topic.id }, 
      function(val, resp) { // success
        _.each(val, function(el) {
          var topic = _.find($scope.topics, function(t) {
            return t.id === el.id;
          });
          topic.ordr = el.ordr; // update object in array
        });
        // reorder topics
        $scope.topics = $filter('orderBy')($scope.topics, '+ordr');
      }, 
      function(resp) {
        // error
      });
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

fiApp.controller('BenchmarksCtrl', ['$scope', 'BenchmarksSrv', '$filter', 
                  function($scope, Benchmarks, $filter) {
  
  $scope.topicId = $scope.$parent.topic.id;
  $scope.benchmarks = Benchmarks.query({ topic_id: $scope.topicId });
  $scope.submitted = false;
  
  var createBenchmark = function(newBenchmark) {
    Benchmarks.save({ topic_id: $scope.topicId, benchmark: newBenchmark },
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
      $scope.benchmarks = Benchmarks.query({ topic_id: $scope.topicId });
      $scope.editableBenchmark = {};
      $scope.editableBenchmarkForm.$setPristine();
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
      // console.log('form not valid');
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
      }, 
      function(resp) {
        // error
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
      }, 
      function(resp) {
        // error
      });
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
