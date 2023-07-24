class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.belongs_to :tournament_level, index: true
      t.belongs_to :course, index: true
      t.string :name, index: { unique: true }
      
      t.timestamps
    end
  end
end
