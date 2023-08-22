class GolferEvent < ApplicationRecord
  has_many :golfer_rounds
  belongs_to :golfer_season
  has_one :golfer, through: :golfer_season
end
