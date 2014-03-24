
json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :user_id
  json.feedback_path root_path(anchor: user_feedback_path(feedback.user_id, feedback.user.slug))
end
