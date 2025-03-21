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

ActiveRecord::Schema[7.2].define(version: 2025_03_21_111627) do
  create_table "answers", force: :cascade do |t|
    t.string "user_name"
    t.string "description"
    t.string "answer_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "task_id"
    t.integer "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "user_name_title"
    t.text "body_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_id", null: false
    t.integer "user_id"
    t.integer "comment_id"
    t.index ["answer_id"], name: "index_comments_on_answer_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "cover_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.text "bio"
    t.string "avatar"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "descroption"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "theme_id", null: false
    t.integer "user_id"
    t.string "username"
    t.index ["theme_id"], name: "index_tasks_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "theme_title"
    t.string "theme_descr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "theme_cover"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "answers"
  add_foreign_key "profiles", "users", on_delete: :cascade
  add_foreign_key "tasks", "themes"
end
