class Evaluation < ActiveRecord::Base
  
  include Upgradable
  
  scope :in_account, ->(account_id) { joins(:evaluation_session).where('account_id = ?', account_id) }
  
  belongs_to :evaluation_session, primary_key: :id, foreign_key: :session_id
  
  has_one :user, primary_key: :user_id, foreign_key: :id
  has_one :form, primary_key: :form_id, foreign_key: :id
  
  has_many :user_evaluations, dependent: :destroy
  
  before_save :assign_user_form_id, on: :create
  
  #before_validation :check_plan_evaluation, on: :create
  
  def assign_user_form_id
    form_user = ::FormUser.where(user_id: self.user_id).take
    self.form_id = form_user.form_id
  end
  
  def to_param
    [id, self.slug].join('/')
  end
  
  # pretty urls, no other use
  def slug
    self.user.slug
  end
  
end
