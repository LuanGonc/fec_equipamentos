class CreateCollaborators < ActiveRecord::Migration[7.1]
  def change
    create_table :collaborators do |t|
      t.string :name, null: false
      t.string :email
      t.string :department

      t.timestamps
    end
  end
end
