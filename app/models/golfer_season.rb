class GolferSeason < ApplicationRecord
  has_many :golfer_events
  has_many :golfer_rounds, through: :golfer_events
  belongs_to :golfer
  belongs_to :season

  def self.create_for_current_season
    Golfer.all.each do |golfer|
      create(golfer: golfer, season: Season.current)
    end
  end

  def gamertag
    golfer.gamertag
  end
end
