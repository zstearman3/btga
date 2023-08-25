class DashboardsController < ApplicationController
  def countdown
    start_date = Date.new(2023, 8, 21)
    @days_until = (start_date - Date.today).to_i
  end

  def main
    @season = Season.current
    @event = Event.current
    @next_event = Event.next
    @scores = @event&.golfer_events&.includes(:golfer_rounds, golfer_season: [:golfer])&.order(score: :asc)
    @golfer_seasons = @season.golfer_seasons.includes(:golfer_events, :golfer).order(points: :desc)
    @admin = params[:admin]
  end
end
