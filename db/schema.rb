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

ActiveRecord::Schema.define(version: 20160306023347) do

  create_table "appointments", force: :cascade do |t|
    t.string   "id_token",                  limit: 255,                   null: false
    t.integer  "company_id",                limit: 4
    t.integer  "branch_id",                 limit: 4
    t.integer  "client_id",                 limit: 4
    t.boolean  "shared",                                  default: false
    t.datetime "date_time",                                               null: false
    t.string   "status",                    limit: 255
    t.string   "photo",                     limit: 255
    t.string   "task_type",                 limit: 50
    t.text     "task_note",                 limit: 65535
    t.float    "total_project_price",       limit: 24
    t.float    "task_payment",              limit: 24
    t.float    "remaining_project_payment", limit: 24
    t.boolean  "needs_folloup",                           default: false
    t.string   "time_zone",                 limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "appointments", ["branch_id"], name: "index_appointments_on_branch_id", using: :btree
  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id", using: :btree
  add_index "appointments", ["company_id"], name: "index_appointments_on_company_id", using: :btree
  add_index "appointments", ["id_token", "date_time"], name: "index_appointments_on_id_token_and_date_time", using: :btree

  create_table "assignments", force: :cascade do |t|
    t.integer  "appointment_id",   limit: 4
    t.integer  "professional_id",  limit: 4
    t.float    "professional_fee", limit: 24
    t.text     "note",             limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "assignments", ["appointment_id", "professional_id"], name: "index_assignments_on_appointment_id_and_professional_id", using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "id_token",        limit: 255,                 null: false
    t.integer  "company_id",      limit: 4
    t.string   "id_code",         limit: 25
    t.string   "name",            limit: 50,                  null: false
    t.string   "email",           limit: 255, default: "@",   null: false
    t.boolean  "pass_active",                 default: false
    t.boolean  "acc_active",                  default: false
    t.string   "password_digest", limit: 255
    t.datetime "last_in"
    t.boolean  "is_default",                  default: false
    t.string   "time_zone",       limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "branches", ["company_id"], name: "index_branches_on_company_id", using: :btree
  add_index "branches", ["id_token", "email"], name: "index_branches_on_id_token_and_email", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "id_token",   limit: 255,                 null: false
    t.integer  "company_id", limit: 4
    t.integer  "branch_id",  limit: 4
    t.string   "id_code",    limit: 25
    t.string   "first_name", limit: 50,                  null: false
    t.string   "last_name",  limit: 50,                  null: false
    t.date     "dob",                                    null: false
    t.string   "email",      limit: 255, default: "@"
    t.string   "photo",      limit: 255
    t.boolean  "is_default",             default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "clients", ["branch_id"], name: "index_clients_on_branch_id", using: :btree
  add_index "clients", ["company_id"], name: "index_clients_on_company_id", using: :btree
  add_index "clients", ["dob"], name: "index_clients_on_dob", using: :btree
  add_index "clients", ["first_name"], name: "index_clients_on_first_name", using: :btree
  add_index "clients", ["id_token", "email"], name: "index_clients_on_id_token_and_email", using: :btree
  add_index "clients", ["last_name"], name: "index_clients_on_last_name", using: :btree

  create_table "clients_professionals", id: false, force: :cascade do |t|
    t.integer "client_id",       limit: 4
    t.integer "professional_id", limit: 4
  end

  add_index "clients_professionals", ["client_id", "professional_id"], name: "index_clients_professionals_on_client_id_and_professional_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "id_token",        limit: 255,                 null: false
    t.string   "id_code",         limit: 25
    t.string   "name",            limit: 50,                  null: false
    t.string   "email",           limit: 255, default: "@",   null: false
    t.boolean  "pass_active",                 default: false
    t.boolean  "acc_active",                  default: false
    t.string   "password_digest", limit: 255
    t.datetime "last_in"
    t.boolean  "is_virtual",                  default: true
    t.boolean  "is_default",                  default: false
    t.string   "time_zone",       limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "companies", ["id_token", "email"], name: "index_companies_on_id_token_and_email", using: :btree

  create_table "contact_details", force: :cascade do |t|
    t.integer  "company_id",      limit: 4
    t.integer  "branch_id",       limit: 4
    t.integer  "professional_id", limit: 4
    t.integer  "client_id",       limit: 4
    t.string   "address_type",    limit: 255
    t.string   "address",         limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "country",         limit: 255
    t.string   "tel",             limit: 255
    t.boolean  "validated",                   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "contact_details", ["branch_id"], name: "index_contact_details_on_branch_id", using: :btree
  add_index "contact_details", ["client_id"], name: "index_contact_details_on_client_id", using: :btree
  add_index "contact_details", ["company_id"], name: "index_contact_details_on_company_id", using: :btree
  add_index "contact_details", ["professional_id"], name: "index_contact_details_on_professional_id", using: :btree

  create_table "employments", force: :cascade do |t|
    t.integer  "company_id",      limit: 4
    t.integer  "professional_id", limit: 4
    t.boolean  "validated",                     default: false
    t.text     "note",            limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "employments", ["company_id", "professional_id"], name: "index_employments_on_company_id_and_professional_id", using: :btree

  create_table "professionals", force: :cascade do |t|
    t.string   "id_token",        limit: 255,                 null: false
    t.string   "id_code",         limit: 25
    t.string   "first_name",      limit: 50,                  null: false
    t.string   "last_name",       limit: 50,                  null: false
    t.date     "dob",                                         null: false
    t.string   "email",           limit: 255, default: "@",   null: false
    t.string   "speciality",      limit: 25
    t.boolean  "pass_active",                 default: false
    t.boolean  "acc_active",                  default: false
    t.string   "password_digest", limit: 255
    t.datetime "last_in"
    t.boolean  "is_virtual",                  default: true
    t.boolean  "is_default",                  default: false
    t.string   "time_zone",       limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "professionals", ["dob"], name: "index_professionals_on_dob", using: :btree
  add_index "professionals", ["id_token", "email"], name: "index_professionals_on_id_token_and_email", using: :btree

end
