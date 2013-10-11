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

ActiveRecord::Schema.define(version: 20131010004526) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "provider_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "collaborations", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "accepted_at"
  end

  add_index "collaborations", ["user_id", "project_id"], name: "index_collaborations_on_user_id_and_project_id", unique: true, using: :btree

  create_table "connections", force: true do |t|
    t.integer  "user_id"
    t.integer  "connected_to"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.time     "sent_at"
    t.time     "accepted_at"
  end

  add_index "connections", ["user_id", "connected_to"], name: "index_connections_on_user_id_and_connected_to", unique: true, using: :btree

  create_table "imported_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",      null: false
    t.integer  "referer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "imported_contacts", ["email"], name: "index_imported_contacts_on_email", unique: true, using: :btree

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.integer  "referer_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "invitations", ["email", "referer_id"], name: "index_invitations_on_email_and_referer_id", unique: true, using: :btree

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "company"
    t.integer  "user_id"
    t.string   "video"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "media_url"
    t.string   "contribution"
    t.date     "start_at"
    t.string   "embed_html"
    t.string   "thumbnail_url"
    t.string   "media_type"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "tagger_id", "tagger_type", "context"], name: "tagging_index", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "user_invites", force: true do |t|
    t.string   "token"
    t.datetime "used_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "invitation_token",       limit: 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "location"
    t.string   "job_title"
    t.datetime "invited_contacts"
    t.datetime "invitation_created_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
