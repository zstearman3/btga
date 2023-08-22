class CreateGolferSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :golfer_seasons do |t|
      t.integer :events
      t.integer :wins
      t.integer :points
      t.integer :rank
      t.boolean :champion
      t.belongs_to :golfer, index: true, null: false
      t.belongs_to :season, index: true, null: false

      t.timestamps
    end
  end
end
