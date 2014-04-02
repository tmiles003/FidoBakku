class RenameBenchmarksToCompetencies < ActiveRecord::Migration
  def change
    rename_table :benchmarks, :competencies
  end
end
