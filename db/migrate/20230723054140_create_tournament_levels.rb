class CreateTournamentLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :tournament_levels do |t|
      t.integer :name, default: 0
      t.timestamps
    end
  end
end
