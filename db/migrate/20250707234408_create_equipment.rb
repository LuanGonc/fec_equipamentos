class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :brand, null: false
      t.string :model, null: false
      t.string :patrimony_number, index: { unique: true }, null: false
      t.string :serial_number, index: { unique: true }, null: false
      t.string :identifier, index: { unique: true }, null: false
      t.date :purchase_date
      t.date :manufacture_date
      t.text :description
      t.string :status, null: false, default: 'disponível'

      t.timestamps
    end
  end
end
