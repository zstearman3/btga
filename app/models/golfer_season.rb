class GolferSeason < ApplicationRecord
  has_many :golfer_events
  has_many :golfer_rounds, through: :golfer_events
  belongs_to :golfer
  belongs_to :season

  def update_points
    points_array = golfer_events.where(completed: true).order(points: :desc).pluck(:points)
    points_array = points_array.first(scores_to_count).compact

    return unless points_array.length > 0
    points_total = points_array.try(:sum)

    update!(points: points_total)
  end

  def update_rank
    calculated_rank = GolferSeason.where(season: season).where("points > ?", points).count + 1
    update!(rank: calculated_rank)
  end

  def gamertag
    golfer.gamertag
  end

  def self.create_for_current_season
    Golfer.all.each do |golfer|
      create(golfer: golfer, season: Season.current)
    end
  end

  private

  def scores_to_count
    season.completed_events - (season.completed_events / 6.0).floor
  end
end
