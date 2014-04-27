# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140427070641) do

  create_table "account_users", force: true do |t|
    t.integer "account_id"
    t.integer "user_id"
  end

  add_index "account_users", ["account_id"], name: "index_account_users_on_account_id", using: :btree
  add_index "account_users", ["user_id"], name: "index_account_users_on_user_id", using: :btree

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "owner_id"
    t.string   "plan"
    t.string   "key"
    t.date     "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "evaluation_id"
    t.integer  "goal_id"
    t.integer  "user_evaluation_id"
    t.text     "content"
    t.datetime "created_at"
  end

  add_index "comments", ["evaluation_id"], name: "index_comments_on_evaluation_id", using: :btree
  add_index "comments", ["goal_id"], name: "index_comments_on_goal_id", using: :btree
  add_index "comments", ["user_evaluation_id"], name: "index_comments_on_user_evaluation_id", using: :btree

  create_table "evaluation_sessions", force: true do |t|
    t.integer  "account_id"
    t.string   "title"
    t.text     "progress"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: true do |t|
    t.integer  "account_id"
    t.integer  "evaluation_session_id"
    t.integer  "user_id"
    t.integer  "form_id"
    t.string   "mode"
    t.text     "progress"
    t.integer  "rating"
    t.boolean  "done"
    t.datetime "created_at"
  end

  add_index "evaluations", ["evaluation_session_id"], name: "index_evaluations_on_evaluation_session_id", using: :btree

  create_table "form_competencies", force: true do |t|
    t.integer  "account_id"
    t.integer  "form_section_id"
    t.text     "content"
    t.integer  "ordr"
    t.boolean  "in_use"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_competencies", ["form_section_id"], name: "index_form_competencies_on_form_section_id", using: :btree

  create_table "form_parts", force: true do |t|
    t.integer "account_id"
    t.integer "form_id"
    t.integer "part_id"
  end

  add_index "form_parts", ["form_id", "part_id"], name: "index_form_parts_on_form_id_and_part_id", unique: true, using: :btree

  create_table "form_sections", force: true do |t|
    t.integer  "account_id"
    t.integer  "form_id"
    t.string   "name"
    t.integer  "ordr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_sections", ["form_id"], name: "index_form_sections_on_form_id", using: :btree

  create_table "form_users", force: true do |t|
    t.integer "account_id"
    t.integer "form_id"
    t.integer "user_id"
  end

  add_index "form_users", ["form_id"], name: "index_form_users_on_form_id", using: :btree
  add_index "form_users", ["user_id"], name: "index_form_users_on_user_id", using: :btree

  create_table "forms", force: true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.boolean  "shared"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", force: true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.date     "due_date"
    t.boolean  "private",    default: false
    t.boolean  "done",       default: false
    t.datetime "created_at"
  end

  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "team_users", force: true do |t|
    t.integer "account_id"
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "team_users", ["team_id"], name: "index_team_users_on_team_id", using: :btree
  add_index "team_users", ["user_id"], name: "index_team_users_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.integer "account_id"
    t.string  "name"
  end

  create_table "user_evaluations", force: true do |t|
    t.integer  "account_id"
    t.integer  "evaluation_id"
    t.integer  "evaluator_id"
    t.string   "evaluator_name"
    t.text     "ratings"
    t.integer  "progress"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_evaluations", ["evaluation_id"], name: "index_user_evaluations_on_evaluation_id", using: :btree
  add_index "user_evaluations", ["evaluator_id"], name: "index_user_evaluations_on_evaluator_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
