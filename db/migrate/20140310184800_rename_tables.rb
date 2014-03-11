class RenameTables < ActiveRecord::Migration
  def change
    # ALTER TABLE `fidobakku`.`form_sections` RENAME TO `fidobakku`.`topics`;
    rename_table :form_sections, :topics
    # ALTER TABLE `fidobakku`.`form_section_benchmarks` RENAME TO `fidobakku`.`benchmarks`;
    rename_table :form_section_benchmarks, :benchmarks
    # ALTER TABLE `fidobakku`.`benchmarks` CHANGE COLUMN `section_id` `topic_id` INT(11) DEFAULT NULL;
    rename_column :benchmarks, :section_id, :topic_id
  end
end
