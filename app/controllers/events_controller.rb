class EventsController < ApplicationController
  before_action :select_event, only: [:show, :edit, :update, :destroy]
  
  def index
    @events = Event.all
  end
  
  # def show
  #   @golfer_events = @event.golfer_events.includes(:golfer).order(:finish)  
  # end
    
  def new
    @event = Event.new
    @season = Season.find_by(year: params[:season] || Season::CURRENT_YEAR)
    @season_id = @season&.id
  end
  
  def create
    @event = Event.new(event_params)
    @event.season_order = Season.find(@event.season_id).events.count + 1

    if @event.save
      flash[:success] = "Event added!"
      redirect_to "/seasons/#{@event.season.year}/schedule"
    else
      render 'new'
    end
  end
  
  def edit; end
    
  def update
    if @event.update(event_params)
      flash['success'] = "Event updated!"
      redirect_to schedule(@event.season.year)
    else
      render 'edit'
    end
  end
  
  def destroy
    @event.destroy ? flash[:success] = "Event deleted!" : flash[:danger] = "There was a problem deleting the event!"
    redirect_to "/seasons/#{@event.season.year}/schedule"
  end
  
  # def match_play
  #   @round_one_matchups = @event.match_play_matchups.where(round: 1)
  #   @round_two_winner_matchups = @event.match_play_matchups.where(round: 2, losers_bracket: false)
  #   @round_two_losers_matchups = @event.match_play_matchups.where(round: 2, losers_bracket: true)
  #   @championship = @event.match_play_matchups.find_by(winner_place: 1)
  #   @third_place = @event.match_play_matchups.find_by(winner_place: 3)
  #   @fifth_place = @event.match_play_matchups.find_by(winner_place: 5)
  #   @seventh_place = @event.match_play_matchups.find_by(winner_place: 7)
  # end
  
  # def generate_matchups
  #   if @event.generate_matchups == true
  #     flash[:success] = "Matchups Created!"
  #     redirect_to match_play_path(@event)
  #   else
  #     flash[:warning] = "Matchups could not be generated. Please make sure there are at least 8 eligible players!"
  #     redirect_to match_play_path(@event)
  #   end
  # end
  
  # def finalize_match_play
  #   if @event.finalize_match_play
  #     flash[:success] = "Event Finalized!"
  #     redirect_to @event
  #   else
  #     flash[:warning] = "Event could not be finalized!"
  #     redirect_to match_play_path(@event)
  #   end
  # end
  
  # def finalize
  #   @event.finalize_event ? flash[:success] = "Event finalized!": flash[:warning] = "Event not finalized!"
  #   redirect_to @event
  # end
  
  # def unfinalize
  #   @event.unfinalize_event ? flash[:success] = "Event unfinalized!": flash[:warning] = "Error unfinalizing event!"
  #   redirect_to @event
  # end
  
  private
  
    def select_event
      begin
        @event = Event.includes(:tournament).find(params[:id])
      rescue StandardError => e
        redirect_to schedule_path(Season.current)
        flash[:danger] = e.message
      end
    end
    
    def event_params
      params.require(:event).permit(:season_order, :rounds, :start_date, :end_date, 
                                        :course_id, :society_id, :tournament_id, :season_id, :match_play)
    end
end
