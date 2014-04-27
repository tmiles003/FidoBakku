class Comment < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  
  belongs_to :evaluation
  belongs_to :goal
  belongs_to :user_evaluation
  
  validates :content, presence: true
  
  def serializer
    case 
    when !self.user_evaluation_id.nil?
      serializer = ::Evaluation::CommentSerializer
    when !self.evaluation_id.nil?
      serializer = ::Feedback::CommentSerializer
    when !self.goal_id.nil?
      serializer = ::Goal::CommentSerializer
    end
    
    serializer
  end
  
end
