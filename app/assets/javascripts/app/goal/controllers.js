'use strict';

/* Controllers */

fiApp.controller('GoalCtrl', ['$scope', '$modal', '$filter', 'GoalSrv', 'goal', 'CommentsSrv', 'NotifSrv', 
                  function($scope, $modal, $filter, GoalSrv, goal, CommentsSrv, NotifSrv) {
  
  $scope.goal = goal;
  $scope.comments = goal.comments;
  $scope.eComment = { goal_id: $scope.goal.id };
  
  $scope.saveGoal = function(goal) {
    goal.$update(function(val, resp) {
      $scope.eGoalForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.format = 'd MMMM yyyy';
  $scope.minDate = new Date();
  
  $scope.openDatePicker = function($event) {
    $event.preventDefault();
    $event.stopPropagation();
    $scope.opened = true;
  };
  
  $scope.$watch('goal.due_date', function(newVal, oldVal) {
    // returned date from picker is "Fri May 09 2014 05:30:00 GMT+0530 (India Standard Time)", 
    // *not* "2014-04-21", which causes 2 saves in a row as the date flip-flops between the 2 formats
    // so, $filter to the rescue, to format both passed values to the same format (same format as db)
    newVal = $filter('date')(newVal, 'yyyy-MM-dd');
    oldVal = $filter('date')(oldVal, 'yyyy-MM-dd');
    if (newVal !== oldVal) {
      goal.$update(function() {
        NotifSrv.success();
      });
    }
  });
  
  $scope.datePickerOptions = {
    'year-format': "'yy'",
    'starting-day': 1,
    'show-weeks': false
  };
  
  $scope.saveComment = function(comment, isValid) {
    $scope.submitted = true;
    if (isValid) {
      $scope.submitted = false;
      CommentsSrv.save({ comment: comment }, function(val, resp) {
        $scope.comments.push(val);
        $scope.eComment = { goal_id: $scope.goal.id };
        $scope.eCommentForm.$setPristine();
        NotifSrv.success();
      });
    }
  }
  
  $scope.clearForm = function() {
    $scope.submitted = false;
    $scope.eComment = {};
    $scope.eCommentForm.$setPristine();
  }
  
  $scope.deleteConfirm = function(comment) {
    var modalInstance = $modal
      .open({
        templateUrl: '/templates/goal/comment-delete.html',
        controller: deleteCommentCtrl,
        resolve: {
          comment: function() { return comment; }
        }
      })
      .result.then(function(comment) {
        deleteComment(comment);
      });
  }
  
  var deleteCommentCtrl = function($scope, $modalInstance, comment) {
    $scope.comment = comment;
    $scope.delete = function() {
      $modalInstance.close($scope.comment);
    }
  }
  
  var deleteComment = function(comment) {
    CommentsSrv.delete({ id: comment.id }, function() {
      $scope.comments = _.without($scope.comments, comment);
      NotifSrv.success();
    });
  }
  
}]);
