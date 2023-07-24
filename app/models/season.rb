class Season < ApplicationRecord
  CURRENT_YEAR = 2023

  validates :year, presence: true, uniqueness: true, numericality: { only_integer: true }

  def self.current
    find_by(year: CURRENT_YEAR)
  end
end
