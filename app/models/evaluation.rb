class Evaluation < ActiveRecord::Base
  
  include InAccount
  
  MODES = %w[evaluations feedback]
  
  belongs_to :evaluation_loop
  belongs_to :account
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id
  has_one :comment, primary_key: :id, foreign_key: :evaluation_id, dependent: :destroy
  
  has_many :user_evaluations, dependent: :destroy
  
  before_create :initial_setup
  before_save :assign_user_form_id, on: :create
  after_create :add_to_evaluation_loop
  after_update :update_evaluation_loop
  before_destroy :remove_from_evaluation_loop
  
  def assign_user_form_id
    form_user = ::FormUser.where(user_id: self.user_id).take
    self.form_id = form_user.form_id
  end
  
  def set_done
    # remove mode
  end
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.user.slug
  end
  
  protected
  
  def initial_setup
    self.progress = ActiveSupport::JSON.encode Hash.new
  end
  
  def add_to_evaluation_loop
    evaluation_loop = EvaluationLoop.find(self.evaluation_loop_id)
    progress_h = ActiveSupport::JSON.decode evaluation_loop.progress
    e_id = self.id.to_s
    progress_h[e_id] = 0
    
    evaluation_loop.update(progress: ActiveSupport::JSON.encode(progress_h))
  end
  
  # sets the progress in the evaluation evaluation_loop - saves db calls for stats
  def update_evaluation_loop
    evaluation_loop = EvaluationLoop.find(self.evaluation_loop_id)
    evaluation_loop_progress_h = ActiveSupport::JSON.decode evaluation_loop.progress
    
    e_id = self.id.to_s
    
    evaluation_progress_h = ActiveSupport::JSON.decode self.progress
    sum = 0
    evaluation_progress_h.each_pair { |key, value|
      sum += value
    }
    
    evaluation_loop_progress_h[e_id] = 0
    unless evaluation_progress_h.empty?
      evaluation_progress = sum / evaluation_progress_h.size
      evaluation_loop_progress_h[e_id] = evaluation_progress
    end
    
    evaluation_loop.update(progress: ActiveSupport::JSON.encode(evaluation_loop_progress_h))
  end
  
  def remove_from_evaluation_loop
    evaluation_loop = EvaluationLoop.find(self.evaluation_loop_id)
    progress_h = ActiveSupport::JSON.decode evaluation_loop.progress
    e_id = self.id.to_s
    progress_h.delete(e_id)
    
    evaluation_loop.update(progress: ActiveSupport::JSON.encode(progress_h))
  end
  
end
