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

ActiveRecord::Schema.define(version: 20160323021023) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "index"
    t.string   "notes"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "newreleases", force: :cascade do |t|
    t.string   "item_code"
    t.string   "discount_code"
    t.string   "title"
    t.string   "price"
    t.string   "vendor"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "newseries", force: :cascade do |t|
    t.string   "vendor_name"
    t.string   "item_number"
    t.string   "discount_code"
    t.string   "preview_page_no"
    t.string   "description"
    t.string   "price"
    t.string   "srp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "book_index"
    t.integer  "name_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "quantity"
    t.date     "date_added"
  end

  create_table "subscribers", force: :cascade do |t|
    t.integer  "index"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "start_date"
    t.string   "mail_list"
    t.string   "last_edit"
    t.string   "subscriber_type"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers_books", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "book_id"
  end

end
