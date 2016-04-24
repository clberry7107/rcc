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

ActiveRecord::Schema.define(version: 20160424173311) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "index"
    t.string   "notes"
    t.boolean  "active"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "stock_quantity"
  end

  create_table "fans", force: :cascade do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email",      null: false
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
    t.string   "last_name",       default: ""
    t.string   "first_name",      default: ""
    t.string   "address",         default: ""
    t.string   "city",            default: ""
    t.string   "state",           default: ""
    t.string   "zip",             default: ""
    t.string   "home_phone",      default: ""
    t.string   "work_phone",      default: ""
    t.string   "start_date",      default: ""
    t.string   "mail_list",       default: ""
    t.string   "last_edit"
    t.string   "subscriber_type", default: ""
    t.text     "notes",           default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile_phone",    default: ""
    t.string   "email",           default: ""
  end

  create_table "subscribers_books", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "book_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "user_type",              default: "guest", null: false
    t.string   "f_name"
    t.string   "l_name"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
