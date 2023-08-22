class GolferSeason < ApplicationRecord
  has_many :golfer_events
  has_many :golfer_rounds, through: :golfer_events
  belongs_to :golfer
end
