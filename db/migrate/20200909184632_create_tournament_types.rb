class CreateTournamentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_types do |t|
      t.string :type
      t.timestamps
    end
  end
end
