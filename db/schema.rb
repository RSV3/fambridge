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

ActiveRecord::Schema.define(version: 20140127223109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "care_receivers", force: true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "care_receivers", ["name", "creator_id"], name: "index_care_receivers_on_name_and_creator_id", unique: true, using: :btree

  create_table "care_relationships", force: true do |t|
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "care_relationships", ["giver_id", "receiver_id"], name: "index_care_relationships_on_giver_id_and_receiver_id", unique: true, using: :btree
  add_index "care_relationships", ["giver_id"], name: "index_care_relationships_on_giver_id", using: :btree
  add_index "care_relationships", ["receiver_id"], name: "index_care_relationships_on_receiver_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "categories_contents", force: true do |t|
    t.integer "category_id"
    t.integer "content_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "writer_id"
    t.integer  "feed_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.string   "slug"
    t.string   "url"
    t.boolean  "recent",     default: false
    t.boolean  "important",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["slug"], name: "index_contents_on_slug", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "content_type"
    t.string   "content_img"
    t.string   "content_url"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["author_id", "created_at"], name: "index_feeds_on_author_id_and_created_at", using: :btree
  add_index "feeds", ["content_type"], name: "index_feeds_on_content_type", using: :btree
  add_index "feeds", ["created_at"], name: "index_feeds_on_created_at", using: :btree

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.string   "personal_msg"
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", using: :btree
  add_index "invitations", ["giver_id"], name: "index_invitations_on_giver_id", using: :btree
  add_index "invitations", ["receiver_id"], name: "index_invitations_on_receiver_id", using: :btree

  create_table "lead_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lead_users", ["email"], name: "index_lead_users_on_email", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "send_weekly_report"
    t.boolean  "agree_terms"
    t.string   "profile_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "super_admin",        default: false
    t.boolean  "primary",            default: false
    t.boolean  "virtual",            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
