class UserReview < ActiveRecord::Base
  
  belongs_to :review #, inverse_of: :user_reviews
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id #, -> { includes :topics }
  has_one :reviewer, class_name: 'User', primary_key: :reviewer_id, foreign_key: :id
  
  before_save :update_progress
  
  protected
  
  def update_progress
    # get benchmark ids from form id
    benchmark_ids = UserReview.find_by_sql ["SELECT b.id FROM benchmarks b 
        JOIN topics t ON t.id = b.topic_id 
        JOIN forms f ON f.id = t.form_id 
      WHERE f.id = ?", form_id]
    
    # decode the scores string into a hash
    scores_h = ActiveSupport::JSON.decode scores
    # create temp hash for scores
    scores_tmp = Hash.new
    
    # loop through the benchmark ids
    benchmark_ids.each { |b|
      b_id = b.id.to_s # set the id as a string, to use as key
      # if hash has key and value is not empty
      if scores_h.has_key?(b_id) && !scores_h[b_id].to_s.empty?
        # store it in the temp hash
        scores_tmp[b_id] = scores_h[b_id]
      end
      # this ensures a clean scores hash is saved
    }
    
    # the difference between the 2 hashes is the completion progress
    self.progress = ((scores_tmp.count / benchmark_ids.count.to_f) * 100).to_i
     
    self.scores = ActiveSupport::JSON.encode scores_tmp
  end
  
end
