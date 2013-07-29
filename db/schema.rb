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

ActiveRecord::Schema.define(:version => 20130729125647) do

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "provider_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "authentications", ["provider", "user_id"], :name => "index_authentications_on_provider_and_user_id", :unique => true

  create_table "connections", :force => true do |t|
    t.integer  "user_id"
    t.integer  "connected_to"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.time     "sent_at"
    t.time     "accepted_at"
  end

  add_index "connections", ["user_id", "connected_to"], :name => "index_connections_on_user_id_and_connected_to", :unique => true

  create_table "imported_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",      :null => false
    t.integer  "referer_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "imported_contacts", ["email"], :name => "index_imported_contacts_on_email", :unique => true

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "referer_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitations", ["email", "referer_id"], :name => "index_invitations_on_email_and_referer_id", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "company"
    t.integer  "user_id"
    t.string   "video"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "media_url"
    t.string   "embed_url"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
