class Golfer < ApplicationRecord
  has_many :golfer_seasons
  has_many :golfer_events, through: :golfer_seasons
  has_many :golfer_rounds, through: :golfer_events
end
