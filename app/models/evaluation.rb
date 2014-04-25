class Evaluation < ActiveRecord::Base
  
  include InAccount
  
  MODES = %w[evaluations feedback]
  
  belongs_to :evaluation_session
  belongs_to :account
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id
  has_one :comment, primary_key: :id, foreign_key: :evaluation_id, dependent: :destroy
  
  has_many :user_evaluations, dependent: :destroy
  
  before_save :assign_user_form_id, on: :create
  
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
  
end
