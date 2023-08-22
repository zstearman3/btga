class GolferEvent < ApplicationRecord
  attr_accessor :round_1_score, :round_2_score, :round_3_score, :round_4_score

  has_many :golfer_rounds
  belongs_to :golfer_season
  belongs_to :event
  has_one :golfer, through: :golfer_season
  has_one :season, through: :event
  has_one :course, through: :event

  def set_round_accessor_score(round)
    matching_round = golfer_rounds.find_by(event_order: round)
    if matching_round
      score = matching_round.score
    else
      raise "No matching round found."
    end
    if round == 1
      self.round_1_score = score
    elsif round == 2
      self.round_2_score = score
    elsif round == 3
      self.round_3_score = score
    elsif round == 4
      self.round_4_score = score
    else
      raise "#{round} is not a valid round number."
    end
  end

  def calculate_score_to_par
    score - (event.rounds * course.par)
  end
end
