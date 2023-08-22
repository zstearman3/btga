class AddIndiciesToGolfers < ActiveRecord::Migration[7.0]
  def change
    add_index :golfer_seasons, [:golfer_id, :season_id], unique: true
    add_index :golfer_events, [:golfer_season_id, :event_id], unique: true
    add_index :golfer_rounds, [:golfer_event_id, :event_order], unique: true
  end
end
