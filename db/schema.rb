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

ActiveRecord::Schema.define(:version => 20121025122359) do

  create_table "addresses", :force => true do |t|
    t.string  "street"
    t.string  "complement"
    t.string  "number"
    t.string  "district"
    t.string  "city"
    t.string  "state"
    t.string  "country",    :default => "BRA"
    t.string  "zipcode"
    t.integer "voucher_id"
  end

  create_table "backend_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "backend_users", ["email"], :name => "index_backend_users_on_email", :unique => true
  add_index "backend_users", ["reset_password_token"], :name => "index_backend_users_on_reset_password_token", :unique => true

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "franchises", :force => true do |t|
    t.string  "name"
    t.string  "url"
    t.string  "acronym"
    t.boolean "payment_enabled", :default => false
  end

  create_table "franchises_users", :id => false, :force => true do |t|
    t.integer "franchise_id"
    t.integer "user_id"
  end

  create_table "leads", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_code"
    t.string   "phone"
    t.string   "address_search"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "unity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "prospected_at"
    t.datetime "enrolled_at"
    t.integer  "campaign_id"
    t.integer  "franchise_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "voucher_id"
    t.integer  "product_id"
    t.decimal  "price",      :precision => 8, :scale => 2,                :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "quantity",                                 :default => 1, :null => false
  end

  create_table "products", :force => true do |t|
    t.integer "franchise_id"
    t.string  "name",                                       :null => false
    t.text    "description"
    t.decimal "price",        :precision => 8, :scale => 2, :null => false
  end

  create_table "timetables", :force => true do |t|
    t.string "title"
    t.string "description"
  end

  create_table "unities", :force => true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "status"
    t.string  "situation"
    t.string  "franchise_acronym"
    t.string  "email"
    t.string  "phone"
    t.float   "latitude"
    t.float   "longitude"
    t.integer "leads_count",       :default => 0
    t.integer "franchise_id"
    t.string  "address_street"
    t.string  "address_number"
    t.string  "address_district"
    t.string  "address_zipcode"
    t.string  "address_city"
    t.string  "address_state"
  end

  create_table "unities_users", :id => false, :force => true do |t|
    t.integer "unity_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",      :null => false
    t.string   "encrypted_password",     :default => "",      :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "role",                   :default => "unity", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vouchers", :force => true do |t|
    t.integer  "unity_id"
    t.integer  "lead_id"
    t.string   "code"
    t.datetime "used_at"
    t.decimal  "total",           :precision => 8, :scale => 2
    t.string   "payment_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timetable_id"
    t.string   "status"
    t.string   "cpf"
    t.string   "transaction_key"
    t.string   "payment_url"
  end

end
