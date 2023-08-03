class TournamentLevel < ApplicationRecord
  has_many :tournaments
  
  enum :name, [ :standard, :championship, :major, :playoff ]

  STANDARD_POINTS = 
    {
      "1" => 500,
      "2" => 300,
      "3" => 190,
      "4" => 135,
      "5" => 110,
      "6" => 100,
      "7" => 90,
      "8" => 85,
      "9" => 80,
      "10" => 75
    }.freeze

  CHAMPIONSHIP_POINTS = 
    {
      "1" => 550,
      "2" => 315,
      "3" => 200,
      "4" => 140,
      "5" => 115,
      "6" => 105,
      "7" => 95,
      "8" => 89,
      "9" => 83,
      "10" => 78
    }.freeze

  MAJOR_POINTS =
    {
      "1" => 600,
      "2" => 330,
      "3" => 210,
      "4" => 150,
      "5" => 120,
      "6" => 110,
      "7" => 100,
      "8" => 94,
      "9" => 88,
      "10" => 82
    }.freeze

  PLAYOFF_POINTS = 
    {
      "1" => 2000,
      "2" => 1200,
      "3" => 760,
      "4" => 540,
      "5" => 440,
      "6" => 400,
      "7" => 360,
      "8" => 340,
      "9" => 320,
      "10" => 300
    }

  def points_matrix
    case name
    when "standard" 
      STANDARD_POINTS
    when "championship"
      CHAMPIONSHIP_POINTS
    when "major"
      MAJOR_POINTS
    when "playoff"
      PLAYOFF_POINTS
    end
  end
end
