class CreateGolferEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :golfer_events do |t|
      t.boolean :completed, default: false
      t.integer :finish
      t.integer :score
      t.integer :score_to_par
      t.integer :points
      t.belongs_to :golfer_season, index: true, null: false
      t.belongs_to :event, index: true, null: false

      t.timestamps
    end
  end
end
