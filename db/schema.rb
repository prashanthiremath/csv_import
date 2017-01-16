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

ActiveRecord::Schema.define(version: 20170115151236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventories", force: :cascade do |t|
    t.string   "status"
    t.integer  "item_number"
    t.integer  "org_number"
    t.date     "last_ship_date"
    t.date     "due_date"
    t.date     "extract_date"
    t.integer  "quantity"
    t.integer  "lot"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["item_number", "org_number", "lot"], name: "index_inventories_on_item_number_and_org_number_and_lot", unique: true, using: :btree
    t.index ["item_number", "org_number"], name: "index_inventories_on_item_number_and_org_number", unique: true, using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "description"
    t.string   "status"
    t.string   "sales_type"
    t.integer  "item_number"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_number"], name: "index_products_on_item_number", unique: true, using: :btree
  end

end
