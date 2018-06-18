# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_18_092811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "status"
    t.string "priolity"
    t.datetime "deadline"
    t.bigint "label_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_tasks_on_description"
    t.index ["label_id"], name: "index_tasks_on_label_id"
    t.index ["title"], name: "index_tasks_on_title"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.string "email", null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "tasks", "labels"
  add_foreign_key "tasks", "users"
end
