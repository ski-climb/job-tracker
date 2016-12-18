class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :position
      t.string :email
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
