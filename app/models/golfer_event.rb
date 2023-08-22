class GolferEvent < ApplicationRecord
  attr_accessor :round_1_score, :round_2_score, :round_3_score, :round_4_score

  has_many :golfer_rounds, dependent: :destroy
  belongs_to :golfer_season
  belongs_to :event
  has_one :golfer, through: :golfer_season
  has_one :season, through: :event
  has_one :course, through: :event

  TO_PAR_HASH = {

  }

    
  def formatted_score_to_par
    return "-" unless score_to_par

    case
    when score_to_par < 0
      score_to_par.to_s
    when score_to_par == 0
      "E"
    when score_to_par > 0
      "+#{score_to_par.to_s}"
    end
  end

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

  def calculate_finish
    GolferEvent.where(event: event).where("score < ?", score).count + 1
  end
end
