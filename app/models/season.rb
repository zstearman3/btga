class Season < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :golfer_seasons
  validates :year, presence: true, uniqueness: true, numericality: { only_integer: true }
  
  CURRENT_YEAR = 2023

  def completed_events
    events.where(finalized: true).count
  end

  def self.current
    find_or_create_by(year: CURRENT_YEAR)
  end
end
