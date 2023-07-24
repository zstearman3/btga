class Course < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  def self.difficulty_options
    ['Easiest', 'Easy', 'Medium', 'Hard', 'Hardest']
  end
end
