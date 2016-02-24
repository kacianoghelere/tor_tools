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

ActiveRecord::Schema.define(version: 20160224180317) do

  create_table "npc_skills", force: :cascade do |t|
    t.integer  "npc_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "npc_skills", ["npc_id", "created_at"], name: "index_npc_skills_on_npc_id_and_created_at"
  add_index "npc_skills", ["npc_id"], name: "index_npc_skills_on_npc_id"
  add_index "npc_skills", ["skill_id", "created_at"], name: "index_npc_skills_on_skill_id_and_created_at"
  add_index "npc_skills", ["skill_id"], name: "index_npc_skills_on_skill_id"

  create_table "npc_weapons", force: :cascade do |t|
    t.integer  "npc_id"
    t.integer  "weapon_id"
    t.integer  "bonus",      default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "npc_weapons", ["npc_id", "created_at"], name: "index_npc_weapons_on_npc_id_and_created_at"
  add_index "npc_weapons", ["npc_id"], name: "index_npc_weapons_on_npc_id"
  add_index "npc_weapons", ["weapon_id", "created_at"], name: "index_npc_weapons_on_weapon_id_and_created_at"
  add_index "npc_weapons", ["weapon_id"], name: "index_npc_weapons_on_weapon_id"

  create_table "npcs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "img_url"
    t.boolean  "ally",        default: false
    t.integer  "attr_index",  default: 1,     null: false
    t.integer  "resistance",  default: 1,     null: false
    t.integer  "resource",    default: 1,     null: false
    t.integer  "parry",       default: 1,     null: false
    t.integer  "armour",      default: 1,     null: false
    t.integer  "personality", default: 1,     null: false
    t.integer  "movement",    default: 1,     null: false
    t.integer  "perception",  default: 1,     null: false
    t.integer  "survival",    default: 1,     null: false
    t.integer  "custom",      default: 1,     null: false
    t.integer  "vocation",    default: 1,     null: false
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "npcs", ["user_id", "created_at"], name: "index_npcs_on_user_id_and_created_at"
  add_index "npcs", ["user_id"], name: "index_npcs_on_user_id"

  create_table "parties", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parties", ["user_id", "created_at"], name: "index_parties_on_user_id_and_created_at"
  add_index "parties", ["user_id"], name: "index_parties_on_user_id"

  create_table "party_npcs", force: :cascade do |t|
    t.integer  "party_id"
    t.integer  "npc_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "party_npcs", ["npc_id", "created_at"], name: "index_party_npcs_on_npc_id_and_created_at"
  add_index "party_npcs", ["npc_id"], name: "index_party_npcs_on_npc_id"
  add_index "party_npcs", ["party_id", "created_at"], name: "index_party_npcs_on_party_id_and_created_at"
  add_index "party_npcs", ["party_id"], name: "index_party_npcs_on_party_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "skills", ["user_id", "created_at"], name: "index_skills_on_user_id_and_created_at"
  add_index "skills", ["user_id"], name: "index_skills_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "weapon_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.string   "name"
    t.integer  "damage"
    t.integer  "edge"
    t.integer  "injury"
    t.integer  "user_id"
    t.integer  "weapon_category_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "weapons", ["user_id", "created_at"], name: "index_weapons_on_user_id_and_created_at"
  add_index "weapons", ["user_id"], name: "index_weapons_on_user_id"
  add_index "weapons", ["weapon_category_id", "created_at"], name: "index_weapons_on_weapon_category_id_and_created_at"
  add_index "weapons", ["weapon_category_id"], name: "index_weapons_on_weapon_category_id"

end
