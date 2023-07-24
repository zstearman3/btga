class DashboardsController < ApplicationController
  def countdown
    start_date = Date.new(2023, 8, 21)
    @days_until = (start_date - Date.today).to_i
  end

  def main
    @season = Season.current
  end
end
