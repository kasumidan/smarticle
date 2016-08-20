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

ActiveRecord::Schema.define(version: 20160615024802) do

  create_table "items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "smarticle_articles", force: :cascade do |t|
    t.string   "title"
    t.string   "label"
    t.string   "smarticleable_type"
    t.integer  "smarticleable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "smarticle_articles", ["smarticleable_id"], name: "index_smarticle_articles_on_smarticleable_id"
  add_index "smarticle_articles", ["smarticleable_type"], name: "index_smarticle_articles_on_smarticleable_type"

  create_table "smarticle_pictures", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "smarticle_section_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "smarticle_pictures", ["smarticle_section_id"], name: "index_smarticle_pictures_on_smarticle_section_id"

  create_table "smarticle_sections", force: :cascade do |t|
    t.string   "title"
    t.string   "section_type"
    t.integer  "display_order"
    t.integer  "width"
    t.text     "txt"
    t.integer  "smarticle_article_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "smarticle_sections", ["smarticle_article_id"], name: "index_smarticle_sections_on_smarticle_article_id"

  create_table "smarticle_videos", force: :cascade do |t|
    t.text     "video_id"
    t.text     "video_type"
    t.integer  "smarticle_section_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "smarticle_videos", ["smarticle_section_id"], name: "index_smarticle_videos_on_smarticle_section_id"

end
