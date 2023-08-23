class SeasonsController < ApplicationController  
  def schedule
    @season = Season.includes(events: [{tournament: :tournament_level}, :course]).find_by(year: params[:year])
    @previous_season = Season.find_by(year: @season.year - 1)
    @next_season = Season.find_by(year: @season.year + 1)
    @events = @season.events.order(start_date: :asc)
    @admin = params[:admin]
  end
end
