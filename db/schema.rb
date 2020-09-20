# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_20_182221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "started_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_tickets", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "ticket_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_tickets_on_order_id"
    t.index ["ticket_id"], name: "index_order_tickets_on_ticket_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "payment_state", null: false
    t.decimal "paid_amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_orders_on_event_id"
    t.index ["payment_state"], name: "index_orders_on_payment_state"
  end

  create_table "sold_tickets", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "ticket_id", null: false
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_sold_tickets_on_order_id"
    t.index ["ticket_id"], name: "index_sold_tickets_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "selling_option"
    t.integer "quantity"
    t.decimal "price"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "order_tickets", "orders"
  add_foreign_key "order_tickets", "tickets"
  add_foreign_key "orders", "events"
  add_foreign_key "sold_tickets", "orders"
  add_foreign_key "sold_tickets", "tickets"
  add_foreign_key "tickets", "events"
end
