class Event < ApplicationRecord
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
  has_one :tournament_level, through: :tournament
  validates :season_order, numericality: { only_integer: true }
  validates_uniqueness_of :season_id, scope: %i[tournament_id]
  validates_uniqueness_of :start_date

  def tournament_name_with_year
    "#{tournament.name} (#{season.year})"
  end

end
