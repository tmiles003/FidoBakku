class CreateFormSectionBenchmarks < ActiveRecord::Migration
  def change
    create_table :form_section_benchmarks do |t|
      t.integer :section_id
      t.text :content
      t.integer :ordr

      t.timestamps
    end
  end
end
