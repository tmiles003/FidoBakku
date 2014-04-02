class Section < ActiveRecord::Base
  
  include Upgradable
  
  belongs_to :form
  
  has_many :benchmarks, class_name: 'TopicBenchmark', foreign_key: :topic_id, dependent: :destroy
  
  before_validation :check_plan_sections, on: :create
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def next_ordr
    section = ::Section.where(form_id: self.form_id).order(ordr: :desc).take
    self.ordr = section.nil? ? 10 : section.ordr + 10
  end
  
end
