class Event < ApplicationRecord
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
  has_one :tournament_level, through: :tournament
  has_many :golfer_events
  validates :season_order, numericality: { only_integer: true }
  validates_uniqueness_of :season_id, scope: %i[tournament_id]
  validates_uniqueness_of :start_date

  def tournament_name_with_year
    "#{tournament.name} (#{season.year})"
  end

  def time_until
    start_time = start_date.to_datetime
    difference = start_time - DateTime.now
    hours = ((difference * 24) - (difference.floor * 24)).round

    if difference.floor > 0
      return "#{difference.floor} Days, #{hours} Hours"
    end

    return "#{hours} Hours" 
  end

  def self.current
    find_by('start_date <= ? AND end_date > ?', Date.today, Date.today)
  end

  def self.next
    where('start_date > ?' , Date.today).order(start_date: :asc).first
  end

end
