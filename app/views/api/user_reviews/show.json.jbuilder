
json.user_review do
  json.scores @user_review.scores
  json.form do 
    json.name @user_review.form.name
    json.topics @user_review.form.topics do |topic|
      json.name topic.name
      json.ordr topic.ordr
      json.benchmarks topic.benchmarks do |benchmark|
        json.id benchmark.id
        json.content benchmark.content
        json.ordr benchmark.ordr
      end
    end
  end
  json.reviewer @user_review.reviewer, :name
  json.user @user_review.user, :name
end
