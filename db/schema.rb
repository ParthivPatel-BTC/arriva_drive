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

ActiveRecord::Schema.define(version: 20140605124134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "activity_type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "behaviour_id"
    t.boolean  "complete"
  end

  create_table "activity_answer_participants", force: true do |t|
    t.integer  "activity_id"
    t.integer  "answer_id"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_answer_participants", ["activity_id"], name: "index_activity_answer_participants_on_activity_id", using: :btree
  add_index "activity_answer_participants", ["answer_id"], name: "index_activity_answer_participants_on_answer_id", using: :btree
  add_index "activity_answer_participants", ["participant_id"], name: "index_activity_answer_participants_on_participant_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "anonymous_activities", force: true do |t|
    t.integer  "note_id"
    t.integer  "behaviour_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "anonymous_activities", ["behaviour_id"], name: "index_anonymous_activities_on_behaviour_id", using: :btree
  add_index "anonymous_activities", ["note_id"], name: "index_anonymous_activities_on_note_id", using: :btree

  create_table "answers", force: true do |t|
    t.string   "answer_text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "multiple_choice_question_id"
  end

  add_index "answers", ["multiple_choice_question_id"], name: "index_answers_on_multiple_choice_question_id", using: :btree

  create_table "behaviours", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "behaviours_events", force: true do |t|
    t.integer "behaviour_id"
    t.integer "event_id"
  end

  add_index "behaviours_events", ["behaviour_id", "event_id"], name: "index_behaviours_events_on_behaviour_id_and_event_id", using: :btree

  create_table "behaviours_values", force: true do |t|
    t.integer "behaviour_id"
    t.integer "value_id"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "location"
    t.date     "event_date"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.time     "event_start_time"
    t.time     "event_end_time"
  end

  create_table "multiple_choice_questions", force: true do |t|
    t.string   "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
  end

  add_index "multiple_choice_questions", ["activity_id"], name: "index_multiple_choice_questions_on_activity_id", using: :btree

  create_table "networks", force: true do |t|
    t.integer  "current_participant_id"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  create_table "participants", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job_title"
    t.integer  "division"
    t.integer  "year_started"
    t.string   "performance_summary"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "active",                 default: true
  end

  add_index "participants", ["email"], name: "index_participants_on_email", unique: true, using: :btree
  add_index "participants", ["reset_password_token"], name: "index_participants_on_reset_password_token", unique: true, using: :btree

  create_table "reviews", force: true do |t|
    t.text     "review_text"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
  end

  add_index "reviews", ["activity_id"], name: "index_reviews_on_activity_id", using: :btree
  add_index "reviews", ["participant_id"], name: "index_reviews_on_participant_id", using: :btree

  create_table "scores", force: true do |t|
    t.integer  "participant_id"
    t.integer  "scorable_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scorable_type"
  end

  create_table "tags", force: true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["note_id"], name: "index_tags_on_note_id", using: :btree
  add_index "tags", ["taggable_id", "taggable_type"], name: "index_tags_on_taggable_id_and_taggable_type", using: :btree

  create_table "participant_attachments", force: true do |t|
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "values", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
