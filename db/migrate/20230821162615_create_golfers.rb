class CreateGolfers < ActiveRecord::Migration[7.0]
  def change
    create_table :golfers do |t|
      t.string :name, index: true, null: false
      t.string :gamertag, null: false
      t.decimal :handicap
      t.integer :victories

      t.timestamps
    end
  end
end
