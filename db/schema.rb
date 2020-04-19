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

ActiveRecord::Schema.define(version: 2020_04_12_134849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "package_version_id"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_version_id"], name: "index_authors_on_package_version_id"
    t.index ["person_id"], name: "index_authors_on_person_id"
  end

  create_table "package_versions", force: :cascade do |t|
    t.bigint "package_id"
    t.string "version_number"
    t.string "description"
    t.bigint "maintainer_id"
    t.datetime "publication_date"
    t.string "status"
    t.text "index_raw_data"
    t.text "description_raw_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["package_id", "version_number"], name: "index_package_versions_on_package_id_and_version_number", unique: true
    t.index ["package_id"], name: "index_package_versions_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "title"
    t.bigint "latest_package_version_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_packages_on_title", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
