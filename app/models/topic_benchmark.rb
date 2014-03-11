class TopicBenchmark < ActiveRecord::Base
	
	# there's already a module called "Benchmark" in ruby stdlib
  
  self.table_name = 'benchmarks'
  
  belongs_to :topic
  
end
