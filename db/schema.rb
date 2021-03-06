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

ActiveRecord::Schema.define(version: 20150308155815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.string   "description"
    t.integer  "client_id"
    t.string   "client_type"
    t.integer  "service_id"
    t.text     "permissions"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "accesses", ["client_type", "client_id"], name: "index_accesses_on_client_type_and_client_id", using: :btree
  add_index "accesses", ["service_id"], name: "index_accesses_on_service_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "category"
    t.string   "level"
    t.datetime "time"
    t.string   "service"
    t.string   "hostname"
    t.string   "process"
    t.string   "message"
    t.string   "actor"
    t.string   "action"
    t.string   "target"
    t.string   "reason"
    t.string   "tag"
    t.integer  "client_id"
    t.string   "client_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "dismissed",   default: false
  end

  add_index "logs", ["client_type", "client_id"], name: "index_logs_on_client_type_and_client_id", using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "uuid"
    t.string   "hostname"
    t.string   "address"
    t.string   "description"
    t.string   "api_key"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "servers", ["api_key"], name: "index_servers_on_api_key", unique: true, using: :btree
  add_index "servers", ["uuid"], name: "index_servers_on_uuid", unique: true, using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "base_url"
    t.boolean  "is_public"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "roles"
    t.string   "image"
    t.integer  "siso_uid"
    t.integer  "siso_gid"
    t.boolean  "siso_active"
    t.datetime "last_seen"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "api_key"
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", unique: true, using: :btree

  add_foreign_key "accesses", "services"
end
