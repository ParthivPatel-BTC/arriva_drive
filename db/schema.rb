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

ActiveRecord::Schema.define(version: 20140512090516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "behaviour_id"
  end

  create_table "answers", force: true do |t|
    t.string   "answer_text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  create_table "multiple_choice_questions", force: true do |t|
    t.string   "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
