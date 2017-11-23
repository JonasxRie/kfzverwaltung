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

ActiveRecord::Schema.define(version: 20171123074248) do

  create_table "dokuments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "bezeichnung"
    t.date "speicherdatum"
    t.bigint "fahrzeug_id"
    t.string "typ"
    t.binary "datei"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dateiname"
    t.index ["fahrzeug_id"], name: "index_dokuments_on_fahrzeug_id"
  end

  create_table "fahrzeugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "bezeichnung"
    t.string "kennzeichen"
    t.date "tuv"
    t.integer "baujahr"
    t.text "notizen"
    t.boolean "archiviert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dokuments", "fahrzeugs"
end
