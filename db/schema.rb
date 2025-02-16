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

ActiveRecord::Schema[7.1].define(version: 2025_02_15_143331) do
  create_table "job_applications", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.bigint "job_post_id", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_post_id"], name: "index_job_applications_on_job_post_id"
    t.index ["worker_id"], name: "index_job_applications_on_worker_id"
  end

  create_table "job_posts", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "work_title", null: false
    t.text "work_description", null: false
    t.integer "work_capacity", null: false
    t.date "work_start_date", null: false
    t.date "work_end_date", null: false
    t.integer "work_payment", null: false
    t.string "work_location", null: false
    t.string "work_status", default: "recruiting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_job_posts_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", null: false
    t.string "full_name", null: false
    t.string "furigana", null: false
    t.date "birth_date", null: false
    t.string "address"
    t.json "role", null: false
    t.text "experience", null: false
    t.string "qualification"
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "job_applications", "job_posts"
  add_foreign_key "job_applications", "users", column: "worker_id"
  add_foreign_key "job_posts", "users"
end
