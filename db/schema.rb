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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121006190455) do

  create_table "addresses", :force => true do |t|
    t.string  "street"
    t.string  "complement"
    t.string  "number"
    t.string  "district"
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.string  "zipcode"
    t.integer "lead_id"
  end

  create_table "franchises", :force => true do |t|
    t.string "name"
    t.string "url"
    t.string "acronym"
  end

  create_table "leads", :force => true do |t|
    t.string  "name"
    t.string  "email"
    t.string  "phone_code"
    t.string  "phone"
    t.string  "address_search"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "unity_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "voucher_id"
    t.integer  "product_id"
    t.decimal  "price",      :precision => 8, :scale => 2, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "products", :force => true do |t|
    t.integer "franchise_id"
    t.string  "name",                                       :null => false
    t.text    "description"
    t.decimal "price",        :precision => 8, :scale => 2, :null => false
  end

  create_table "unities", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "status"
    t.string  "situation"
    t.string  "franchise_acronym"
    t.string  "email"
    t.string  "phone"
    t.string  "address"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "leads_count",       :default => 0
  end

  create_table "vouchers", :force => true do |t|
    t.integer  "unity_id"
    t.integer  "lead_id"
    t.string   "code"
    t.datetime "used_at"
  end

end
