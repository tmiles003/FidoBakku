class TopicBenchmark < ActiveRecord::Base
	
	# there's already a module called "Benchmark" in ruby stdlib
  
  include Upgradable
  
  self.table_name = 'benchmarks'
  
  belongs_to :topic
  
  before_validation :check_plan_benchmarks, on: :create
  
  def next_ordr
    benchmark = ::TopicBenchmark.where(topic_id: self.topic_id).order(ordr: :desc).take
    self.ordr = benchmark.nil? ? 10 : benchmark.ordr + 10
  end
  
end
