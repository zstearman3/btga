class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string "name", unique: true
      t.integer "yardage"
      t.integer "par"
      t.string "difficulty"
      t.decimal "star_rating"

      t.timestamps
    end
  end
end
