class RenameFormTables < ActiveRecord::Migration
  def change
    rename_table :competencies, :form_competencies
    rename_table :sections, :form_sections
  end
end
