class Topic < ActiveRecord::Base
  
  belongs_to :form
  
  has_many :benchmarks, class_name: 'TopicBenchmark', dependent: :destroy
  
  validates :name, length: {
    in: 4..250,
    too_short: 'Too short',
    too_long: 'Too long'
  }
  
end
