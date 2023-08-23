class GolferEventsController < ApplicationController
  before_action :select_golfer_event, only: [:edit, :update, :destroy]

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
      redirect_to dashboard_path(admin: true)
    else
      render 'new'
    end
  end

  def edit
    event = @golfer_event.event
    @golfer_seasons = event.season.golfer_seasons.includes(:golfer)
    for i in 1..@golfer_event.golfer_rounds.count
      @golfer_event.set_round_accessor_score(i)
    end
  end
  
  def update
    @golfer_event.assign_attributes(event_params)
    @event = @golfer_event.event
    if @golfer_event.completed
      for i in 1..@event.rounds
        round = @golfer_event.golfer_rounds.find_or_create_by(event_order: i)
        round.init_from_event(i, params[:golfer_event][:"round_#{i}_score"].to_i)
        if !round.save
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
      flash[:success] = "Tournament logged!"
      redirect_to dashboard_path(admin: true)
    else
      render 'edit'
    end
  end
  
  def destroy
    event = @golfer_event.event
    if @golfer_event.destroy 
      event.golfer_events.each do |golfer_event|
        golfer_event.finish = golfer_event.calculate_finish
        golfer_event.save
      end
      flash[:success] = "Event deleted!" 
    else
      flash[:danger] = "There was a problem deleting the event!"
    end
    redirect_to dashboard_path(admin: true)
  end

  private

  def select_golfer_event
    @golfer_event = GolferEvent.find(params[:id])
  end

  def event_params
    params.require(:golfer_event).permit(:completed, :finish, :score, :score_to_par,
                   :points, :golfer_season_id, :event_id, :won_tiebreaker)
  end
end
