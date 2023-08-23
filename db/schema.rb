# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_23_042336) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "yardage"
    t.integer "par"
    t.string "difficulty"
    t.decimal "star_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "season_order"
    t.integer "rounds"
    t.date "start_date"
    t.date "end_date"
    t.bigint "course_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "season_id", null: false
    t.bigint "winner_id"
    t.boolean "finalized"
    t.boolean "match_play"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_events_on_course_id"
    t.index ["season_id"], name: "index_events_on_season_id"
    t.index ["tournament_id"], name: "index_events_on_tournament_id"
    t.index ["winner_id"], name: "index_events_on_winner_id"
  end

  create_table "golfer_events", force: :cascade do |t|
    t.boolean "completed", default: false
    t.integer "finish"
    t.integer "score"
    t.integer "score_to_par"
    t.integer "points"
    t.bigint "golfer_season_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "won_tiebreaker", default: false
    t.index ["event_id"], name: "index_golfer_events_on_event_id"
    t.index ["golfer_season_id", "event_id"], name: "index_golfer_events_on_golfer_season_id_and_event_id", unique: true
    t.index ["golfer_season_id"], name: "index_golfer_events_on_golfer_season_id"
  end

  create_table "golfer_rounds", force: :cascade do |t|
    t.integer "event_order", null: false
    t.integer "score"
    t.integer "score_to_par"
    t.bigint "golfer_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golfer_event_id", "event_order"], name: "index_golfer_rounds_on_golfer_event_id_and_event_order", unique: true
    t.index ["golfer_event_id"], name: "index_golfer_rounds_on_golfer_event_id"
  end

  create_table "golfer_seasons", force: :cascade do |t|
    t.integer "events"
    t.integer "wins"
    t.integer "points"
    t.integer "rank"
    t.boolean "champion"
    t.bigint "golfer_id", null: false
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golfer_id", "season_id"], name: "index_golfer_seasons_on_golfer_id_and_season_id", unique: true
    t.index ["golfer_id"], name: "index_golfer_seasons_on_golfer_id"
    t.index ["season_id"], name: "index_golfer_seasons_on_season_id"
  end

  create_table "golfers", force: :cascade do |t|
    t.string "name", null: false
    t.string "gamertag", null: false
    t.decimal "handicap"
    t.integer "victories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_golfers_on_name"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year"], name: "index_seasons_on_year", unique: true
  end

  create_table "tournament_levels", force: :cascade do |t|
    t.integer "name", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.bigint "tournament_level_id"
    t.bigint "course_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_tournaments_on_course_id"
    t.index ["name"], name: "index_tournaments_on_name", unique: true
    t.index ["tournament_level_id"], name: "index_tournaments_on_tournament_level_id"
  end

end
