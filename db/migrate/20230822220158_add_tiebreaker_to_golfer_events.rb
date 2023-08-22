class AddTiebreakerToGolferEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :golfer_events, :won_tibreaker, :boolean, default: false
  end
end
