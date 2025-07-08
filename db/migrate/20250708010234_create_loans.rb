class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.references :equipment, null: false, foreign_key: true
      t.references :collaborator, null: false, foreign_key: true
      t.string :action, null: false 
      t.date :loan_date
      t.date :return_date
      t.text :return_reason
      t.date :discard_date
      t.text :discard_reason

      t.timestamps
    end
  end
end
