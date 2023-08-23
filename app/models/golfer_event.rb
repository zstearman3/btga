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
    finish = GolferEvent.where(event: event).where("score < ?", score).count + 1
    ties = GolferEvent.where(event: event, score: score, won_tiebreaker: true).where.not(golfer_season: golfer_season)
    
    return finish unless finish == 1 && ties.count > 0

    won_tiebreaker ? 1 : 2
  end

  def calculate_points
    return 0 unless finish

    points_matrix = event.tournament.points_matrix

    ties = GolferEvent.where(event: event, finish: finish).where.not(golfer_season: golfer_season).count
    points = points_matrix[finish.to_s]

    for i in 1..ties 
      points += points_matrix[(finish + i).to_s]
    end
    self.points = points / (ties + 1)
  end

  def update_finish
    update(finish: calculate_finish)
  end

  def update_points
    update(points: calculate_points)
  end
end
