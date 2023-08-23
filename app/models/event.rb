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
    hours = ActionController::Base.helpers.pluralize(
      ((difference * 24) - (difference.floor * 24)).round, "Hour"
    )

    if difference.floor > 0
      return "#{difference.floor} Days, #{hours}"
    end

    return hours 
  end

  def finalize
    golfer_events.includes(event: {tournament: :tournament_level}).each do |golfer_event|
      return false unless golfer_event.completed

      golfer_event.update_finish
      golfer_event.update_points
      golfer_event.save
    end

    update(finalized: true)
  end

  def unfinalize
    golfer_events.update_all(points: 0)
    
    update(finalized: false)
  end

  def self.current
    find_by('start_date <= ? AND end_date > ?', Date.today, Date.today)
  end

  def self.next
    where('start_date > ?' , Date.today).order(start_date: :asc).first
  end

end
