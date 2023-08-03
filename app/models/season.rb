class Season < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :year, presence: true, uniqueness: true, numericality: { only_integer: true }
  
  CURRENT_YEAR = 2023

  def self.current
    find_or_create_by(year: CURRENT_YEAR)
  end
end
