class GolferRound < ApplicationRecord
  belongs_to :golfer_event
  has_one :golfer_season, through: :golfer_event
  has_one :golfer, through: :golfer_season
  has_one :event, through: :golfer_event
  has_one :course, through: :event

    
  def init_from_event(i, score)
    self.score = score
    self.event_order = i
    self.score_to_par = score - golfer_event.course.par
  end
end
