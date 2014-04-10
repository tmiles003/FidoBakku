class UserEvaluation < ActiveRecord::Base
  
  belongs_to :evaluation
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id #, -> { includes :topics }
  has_one :evaluation, primary_key: :evaluation_id, foreign_key: :id
  #has_one :reviewer, class_name: 'User', primary_key: :reviewer_id, foreign_key: :id
  #has_one :comment, foreign_key: :user_evaluation_id
  
  after_validation :initial_setup, on: :create
  before_save :update_progress
  
  def to_param
    [id, self.name].join('/')
  end
  
  # pretty urls, no other use
  def name
    ::User.find(self.user_id).slug
  end
  
  protected
  
  def initial_setup
    self.scores = ActiveSupport::JSON.encode Hash.new
    self.progress = 0
  end
  
  def update_progress
    # get comp ids from form id
    comp_ids = UserEvaluation.find_by_sql ["SELECT c.id FROM competencies c 
        JOIN sections s ON s.id = c.section_id 
        JOIN forms f ON f.id = s.form_id 
      WHERE f.id = ?", form_id]
    
    # decode the scores string into a hash
    scores_h = ActiveSupport::JSON.decode scores
    # create temp hash for scores
    scores_tmp = Hash.new
    
    # loop through the comp ids
    comp_ids.each { |c|
      c_id = c.id.to_s # set the id as a string, to use as key
      # if hash has key and value is not empty
      if scores_h.has_key?(c_id) && !scores_h[c_id].to_s.empty?
        # store it in the temp hash
        scores_tmp[c_id] = scores_h[c_id]
      end
      # this ensures a clean scores hash is saved
    }
    
    # the difference between the 2 hashes is the completion progress
    unless comp_ids.empty?
      self.progress = ((scores_tmp.count / comp_ids.count.to_f) * 100).to_i
    end
     
    self.scores = ActiveSupport::JSON.encode scores_tmp
  end
  
end
