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
  
  $scope.datePickerOptions = {
    'year-format': "'yy'",
    'starting-day': 1,
    'show-weeks': false
  };
  
  $scope.$watch('goal.due_date', function(newVal, oldVal) {
    // removes timezone from picked date
    newVal = $filter('date')(newVal, 'yyyy-MM-dd');
    oldVal = $filter('date')(oldVal, 'yyyy-MM-dd');
    if (newVal !== oldVal) {
      goal.due_date = newVal;
      goal.$update(function(val, resp) {
        $scope.goal = val;
        NotifSrv.success();
      });
    }
  });
  
  $scope.markDonePass = function(goal) {
    GoalSrv.update({ id: goal.id, done: 1 }, function(val, resp) {
      $scope.goal.done = 1;
      NotifSrv.success();
    });
  }
  
  $scope.markDoneFail = function(goal) {
    GoalSrv.update({ id: goal.id, done: 2 }, function(val, resp) {
      $scope.goal.done = 2;
      NotifSrv.success();
    });
  }
  
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
