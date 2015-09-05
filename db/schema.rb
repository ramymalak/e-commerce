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

ActiveRecord::Schema.define(version: 20150905022013) do

  create_table "customers", force: :cascade do |t|
    t.string  "firstname",       limit: 255,                 null: false
    t.string  "lastname",        limit: 255,                 null: false
    t.string  "email",           limit: 255,                 null: false
    t.string  "password_digest", limit: 255
    t.boolean "is_admin",        limit: 1,   default: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer "order_id",    limit: 4,              null: false
    t.integer "product_id",  limit: 4,              null: false
    t.integer "qty",         limit: 4,  default: 1, null: false
    t.float   "unit_price",  limit: 53,             null: false
    t.float   "total_price", limit: 53,             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string  "order_no",     limit: 255
    t.integer "customers_id", limit: 4,                 null: false
    t.float   "total",        limit: 53,  default: 0.0, null: false
    t.date    "date"
  end

  create_table "products", force: :cascade do |t|
    t.string  "description", limit: 255, null: false
    t.string  "name",        limit: 255, null: false
    t.float   "price",       limit: 53,  null: false
    t.integer "status",      limit: 4,   null: false
  end

end
