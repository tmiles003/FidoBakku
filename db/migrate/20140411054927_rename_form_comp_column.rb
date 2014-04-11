class RenameFormCompColumn < ActiveRecord::Migration
  def change
    rename_column :form_competencies, :section_id, :form_section_id
  end
end
