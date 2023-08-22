class GolferEventsController < ApplicationController
  def new
    event = Event.find(params[:event_id])
    @golfer_seasons = event.season.golfer_seasons.includes(:golfer)

    GolferSeason.create_for_current_season if @golfer_seasons.count == 0
    @golfer_event = GolferEvent.new(event: event)
  end
  
  def create
    @golfer_event = GolferEvent.new(event_params)
    @event = Event.find(event_params[:event_id])
    if @golfer_event.completed
      for i in 1..@event.rounds
        new_round = GolferRound.new(golfer_event: @golfer_event)
        new_round.init_from_event(i, params[:golfer_event][:"round_#{i}_score"].to_i)
        if !new_round.save
          raise "Round #{i} was not saved: #{new_round.inspect}"
        end
      end
      @golfer_event.score = 0
      @golfer_event.golfer_rounds.each { |round| @golfer_event.score += round.score }
      @golfer_event.score_to_par = @golfer_event.calculate_score_to_par
    end
    if @golfer_event.save
      @event.golfer_events.each do |event|
        event.finish = event.calculate_finish
        event.save
      end

      flash[:success] = "Scores logged!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:golfer_event).permit(:completed, :finish, :score, :score_to_par,
                   :points, :golfer_season_id, :event_id)
  end
end
