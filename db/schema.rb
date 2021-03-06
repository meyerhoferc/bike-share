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

ActiveRecord::Schema.define(version: 20170201183752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.integer  "bike_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bike_number"], name: "index_bikes_on_bike_number", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", using: :btree
  end

  create_table "conditions", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "max_temperature_f"
    t.float    "mean_temperature_f"
    t.float    "min_temperature_f"
    t.float    "mean_humidity"
    t.float    "mean_visibility"
    t.float    "mean_wind_speed"
    t.float    "precipitation_inches"
    t.string   "zipcode"
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.integer  "dock_count"
    t.string   "city_id"
    t.date     "installation_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "account"
    t.index ["account"], name: "index_subscriptions_on_account", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "duration"
    t.datetime "start_date"
    t.integer  "start_station_id"
    t.datetime "end_date"
    t.integer  "end_station_id"
    t.integer  "bike_id"
    t.integer  "subscription_id"
    t.integer  "zipcode_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "condition_id"
  end

  create_table "zipcodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "zip_code"
    t.index ["zip_code"], name: "index_zipcodes_on_zip_code", using: :btree
  end

end
