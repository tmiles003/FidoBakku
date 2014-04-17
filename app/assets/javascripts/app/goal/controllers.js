'use strict';

/* Controllers */

fiApp.controller('GoalCtrl', ['$scope', '$modal', 'GoalSrv', 'goal', 'CommentsSrv', 'NotifSrv', 
                  function($scope, $modal, GoalSrv, goal, CommentsSrv, NotifSrv) {
  
  $scope.goal = goal;
  $scope.comments = goal.comments;
  $scope.eComment = { goal_id: $scope.goal.id };
  
  $scope.saveGoal = function(goal) {
    GoalSrv.update({ id: goal.id, goal: goal }, function(val, resp) {
      $scope.eGoalForm.$setPristine();
      NotifSrv.success();
    });
  }
  
  $scope.today = function() {
    $scope.dt = new Date();
  };
  $scope.today();

  $scope.showWeeks = true;
  $scope.toggleWeeks = function () {
    $scope.showWeeks = ! $scope.showWeeks;
  };
  $scope.open = function($event) {
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;
  };
  $scope.dateOptions = {
    'year-format': "'yy'",
    'starting-day': 1
  };
  $scope.formats = ['dd-MMMM-yyyy', 'yyyy/MM/dd', 'shortDate'];
  $scope.format = $scope.formats[0];
  
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
