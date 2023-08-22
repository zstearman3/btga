class GolferRound < ApplicationRecord
  belongs_to :golfer_event
  has_one :golfer_season, through: :golfer_event
  has_one :golfer, through: :golfer_season
end
