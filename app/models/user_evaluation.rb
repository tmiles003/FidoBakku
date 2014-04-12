class UserEvaluation < ActiveRecord::Base
  
  belongs_to :evaluation
  has_one :evaluator, class_name: 'User', primary_key: :evaluator_id, foreign_key: :id
  
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
  
end
