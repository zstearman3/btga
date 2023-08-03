class SeedTournamentLevels < ActiveRecord::Migration[7.0]
  def up
    TournamentLevel.create([{name: 0}, {name: 1}, {name: 2}, {name: 3}])
  end

  def down
    TournamentLevel.destroy_all
  end
end
