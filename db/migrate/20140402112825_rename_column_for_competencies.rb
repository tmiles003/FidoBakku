class RenameColumnForCompetencies < ActiveRecord::Migration
  def change
    rename_column(:competencies, :topic_id, :section_id)
  end
end
