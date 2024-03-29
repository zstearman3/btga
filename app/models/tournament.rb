class Tournament < ApplicationRecord
  belongs_to :tournament_level
  belongs_to :course, optional: true

  def home_course
    course ? course.name : 'Rotates'
  end
  
  def level
    tournament_level&.name
  end

  def points_matrix
    tournament_level.points_matrix
  end
end
