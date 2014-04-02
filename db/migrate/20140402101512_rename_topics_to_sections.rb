class RenameTopicsToSections < ActiveRecord::Migration
  def change
    rename_table :topics, :sections
  end
end
