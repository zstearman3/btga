class CreateGolferRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :golfer_rounds do |t|
      t.integer :event_order, null: false
      t.integer :score
      t.integer :score_to_par
      t.belongs_to :golfer_event, index: true, null: false
      
      t.timestamps
    end
  end
end
