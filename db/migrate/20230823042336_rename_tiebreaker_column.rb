class RenameTiebreakerColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :golfer_events, :won_tibreaker, :won_tiebreaker
  end
end
