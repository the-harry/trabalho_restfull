# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_12_203820) do

  create_table "alunos", force: :cascade do |t|
    t.string "nome"
    t.integer "rm"
    t.integer "sala_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sala_id"], name: "index_alunos_on_sala_id"
  end

  create_table "salas", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trabalhos", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "aluno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aluno_id"], name: "index_trabalhos_on_aluno_id"
  end

  add_foreign_key "alunos", "salas"
  add_foreign_key "trabalhos", "alunos"
end
