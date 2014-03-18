class Topic < ActiveRecord::Base
  
  belongs_to :form
  
  has_many :benchmarks, class_name: 'TopicBenchmark', foreign_key: :topic_id, dependent: :destroy
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
  def next_ordr
    topic = ::Topic.where(form_id: self.form_id).order(ordr: :desc).take
    self.ordr = topic.nil? ? 10 : topic.ordr + 10
  end
  
end
