class UserEvaluation < ActiveRecord::Base
  
  belongs_to :evaluation
  has_one :evaluator, class_name: 'User', primary_key: :evaluator_id, foreign_key: :id
  has_one :comment #, dependent: :destroy
  
  after_validation :initial_setup, on: :create
  before_update :update_progress
  
  def to_param
    [id, self.name].join('/')
  end
  
  # pretty urls, no other use
  def name
    self.evaluation.user.slug
  end
  
  protected
  
  def initial_setup
    self.ratings = ActiveSupport::JSON.encode Hash.new
    self.progress = 0
  end
  
  def update_progress    
    parts = ::FormPart.get_parts self.evaluation.form_id
    form_ids = []
    parts.each { |part|
      form_ids << part['form_id']
    }
    
    comp_ids = ::Form.select('form_competencies.id')
      .where(id: form_ids)
      .joins(form_sections: :form_comps)
    
    # decode the ratings string into a hash
    ratings_h = ActiveSupport::JSON.decode ratings
    # create temp hash for ratings
    ratings_tmp = Hash.new
    
    # loop through the comp ids
    comp_ids.each { |c|
      c_id = c.id.to_s # set the id as a string, to use as key
      # if hash has key and value is not empty
      if ratings_h.has_key?(c_id) && !ratings_h[c_id].to_s.empty?
        # store it in the temp hash
        ratings_tmp[c_id] = ratings_h[c_id]
      end
      # this ensures a clean ratings hash is saved
    }
    
    # the difference between the 2 hashes is the completion progress
    unless comp_ids.empty?
      self.progress = ((ratings_tmp.count / comp_ids.count.to_f) * 100).to_i
    end
     
    self.ratings = ActiveSupport::JSON.encode ratings_tmp
  end
  
  def self.user_ratings evaluation_id, form_id, user_id, roles = nil
    # get all the form parts
    parts = ::FormPart.get_parts form_id
    form_ids = []
    parts.each { |part|
      form_ids << part['form_id']
    }
    
    # should have a rating for each of the comps - this is the "master hash"
    comp_ids = ::Form.select('form_competencies.id')
      .where(id: form_ids)
      .joins(form_sections: :form_comps)
    
    if roles.nil?
      user_evals = ::UserEvaluation.select('ratings')
        .where(evaluation_id: evaluation_id)
        .where(evaluator_id: user_id)
    else
      user_evals = ::UserEvaluation.select('ratings')
        .where(evaluation_id: evaluation_id)
        .where.not(evaluator_id: user_id)
        .joins(:evaluator)
        .where('users.role in (?)', roles)
    end
  
    user_rating = nil
    user_ratings = []
    user_evals.each { |user_eval| 
      user_rating = ActiveSupport::JSON.decode user_eval.ratings
      user_ratings << user_rating
    }
    
    all_ratings = Hash.new
    comp_ids.each { |comp|
      user_ratings.each { |user_rating|
        comp_id = comp.id.to_s
        if user_rating.has_key?(comp_id)
          (all_ratings[comp_id] ||= []) << user_rating[comp_id].to_i
        end
      }
    }
    
    avg_ratings = Hash.new
    all_ratings.each_pair { |id, ratings|
      avg_ratings[id] = (ratings.reduce(:+).to_f / ratings.size).round(1)
    }
    
    avg_ratings = avg_ratings.empty? ? nil : avg_ratings
  end
  
end
