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

ActiveRecord::Schema.define(:version => 20121004174702) do

  create_table "franchises", :force => true do |t|
    t.string "name"
    t.string "url"
    t.string "acronym"
  end

  create_table "leads", :force => true do |t|
    t.string "name"
    t.string "email"
    t.string "phone_code"
    t.string "phone"
    t.string "address_search"
    t.float  "latitude"
    t.float  "longitude"
  end

  create_table "unities", :force => true do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.string "situation"
    t.string "franchise_acronym"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.float  "latitude"
    t.float  "longitude"
  end

end
