class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :season_order
      t.integer :rounds
      t.date :start_date
      t.date :end_date
      t.belongs_to :course, index: true, null: false
      t.belongs_to :tournament, index: true, null: false
      t.belongs_to :season, index: true, null: false
      t.belongs_to :winner, index: true
      t.boolean :finalized
      t.boolean :match_play

      t.timestamps
    end
  end
end
