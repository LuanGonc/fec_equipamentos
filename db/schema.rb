# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_708_010_234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'collaborators', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email'
    t.string 'department'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'equipment', force: :cascade do |t|
    t.string 'brand', null: false
    t.string 'model', null: false
    t.string 'patrimony_number', null: false
    t.string 'serial_number', null: false
    t.string 'identifier', null: false
    t.date 'purchase_date'
    t.date 'manufacture_date'
    t.text 'description'
    t.string 'status', default: 'disponível', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['identifier'], name: 'index_equipment_on_identifier', unique: true
    t.index ['patrimony_number'], name: 'index_equipment_on_patrimony_number', unique: true
    t.index ['serial_number'], name: 'index_equipment_on_serial_number', unique: true
  end

  create_table 'loans', force: :cascade do |t|
    t.bigint 'equipment_id', null: false
    t.bigint 'collaborator_id', null: false
    t.string 'loan_action', null: false
    t.date 'loan_date'
    t.date 'return_date'
    t.text 'return_reason'
    t.date 'discard_date'
    t.text 'discard_reason'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['collaborator_id'], name: 'index_loans_on_collaborator_id'
    t.index ['equipment_id'], name: 'index_loans_on_equipment_id'
  end

  add_foreign_key 'loans', 'collaborators'
  add_foreign_key 'loans', 'equipment'
end
