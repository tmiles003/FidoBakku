class CreateFormSections < ActiveRecord::Migration
  def change
    create_table :form_sections do |t|
      t.integer :form_id
      t.string :name
      t.integer :ordr

      t.timestamps
    end
  end
end
