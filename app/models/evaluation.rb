class Evaluation < ActiveRecord::Base
  
  include InAccount
  
  MODES = %w[evaluations feedback]
  
  belongs_to :evaluation_session
  belongs_to :account
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id
  has_one :comment, primary_key: :id, foreign_key: :evaluation_id, dependent: :destroy
  
  has_many :user_evaluations, dependent: :destroy
  
  before_create :initial_setup
  before_save :assign_user_form_id, on: :create
  after_create :add_to_evaluation_session
  after_update :update_evaluation_session
  before_destroy :remove_from_evaluation_session
  
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
  
  def add_to_evaluation_session
    session = EvaluationSession.find(self.evaluation_session_id)
    progress_h = ActiveSupport::JSON.decode session.progress
    e_id = self.id.to_s
    progress_h[e_id] = 0
    
    session.update(progress: ActiveSupport::JSON.encode(progress_h))
  end
  
  # sets the progress in the evaluation session - saves db calls for stats
  def update_evaluation_session
    session = EvaluationSession.find(self.evaluation_session_id)
    session_progress_h = ActiveSupport::JSON.decode session.progress
    
    e_id = self.id.to_s
    
    evaluation_progress_h = ActiveSupport::JSON.decode self.progress
    sum = 0
    evaluation_progress_h.each_pair { |key, value|
      sum += value
    }
    
    session_progress_h[e_id] = 0
    unless evaluation_progress_h.empty?
      evaluation_progress = sum / evaluation_progress_h.size
      session_progress_h[e_id] = evaluation_progress
    end
    
    session.update(progress: ActiveSupport::JSON.encode(session_progress_h))
  end
  
  def remove_from_evaluation_session
    session = EvaluationSession.find(self.evaluation_session_id)
    progress_h = ActiveSupport::JSON.decode session.progress
    e_id = self.id.to_s
    progress_h.delete(e_id)
    
    session.update(progress: ActiveSupport::JSON.encode(progress_h))
  end
  
end
