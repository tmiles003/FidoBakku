class CreateFormUsers < ActiveRecord::Migration
  def change
    create_table :form_users do |t|
      t.references :form, index: true
      t.references :user, index: true, :unique => true

      #t.timestamps
    end
  end
end
