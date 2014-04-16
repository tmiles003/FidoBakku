'use strict';

/* Controllers */

fiApp.controller('GoalCtrl', ['$scope', 'GoalSrv', 'goal', 'CommentsSrv', 'NotifSrv', 
                  function($scope, GoalSrv, goal, CommentsSrv, NotifSrv) {
  
  $scope.goal = goal;
  $scope.comments = goal.comments;
  $scope.eComment = { goal_id: $scope.goal.id };
  
  $scope.saveGoal = function(goal) {
    GoalSrv.update({ id: goal.id, goal: goal }, function(val, resp) {
      $scope.eGoalForm.$setPristine();
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
  
  $scope.deleteComment = function(comment) {
    CommentsSrv.delete({ id: comment.id }, function() {
      $scope.comments = _.without($scope.comments, comment);
      NotifSrv.success();
    });
  }
  
}]);
