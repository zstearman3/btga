class GolfersController < ApplicationController
  before_action :select_golfer, only: [:show, :edit, :update, :destroy]
  
  def index
    @golfers = Golfer.all.order(:handicap)
  end
  
  def show
    @golfer_season = @golfer.golfer_seasons.find_by(season_id: Season.current_id)
    @events = @golfer.golfer_events.joins(:season_tournament).merge(SeasonTournament.order(start_date: :desc))
  end
  
  def new
    @golfer = Golfer.new
  end
  
  def create
    @golfer = Golfer.new(golfer_params)
    @golfer.society = Society.last
    if @golfer.save
      flash[:success] = "Golfer added!"
      redirect_to roster_path
    else
      render 'new'
    end
  end
  
  def edit; end
  
  def update
    if @golfer.update(golfer_params)
      flash[:success] = "Golfer updated!"
      redirect_to roster_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @golfer.destroy ? flash[:success] = "Golfer deleted!" : flash[:danger] = "There was a problem deleting the golfer."
    redirect_to roster_path
  end
  
  def events
    @golfer = Golfer.includes(:golfer_seasons).find(params[:golfer_id])
    @events = @golfer.golfer_events.joins(:season_tournament).merge(SeasonTournament.order(start_date: :desc))
  end
  
  private
    def select_golfer
      begin
        @golfer = Golfer.includes(:golfer_seasons).find(params[:id])
      rescue StandardError => e
        redirect_to roster_path
        flash[:danger] = e.message
      end
    end
  
    def golfer_params
      params.require(:golfer).permit(:name, :gamertag, :handicap, :victories, :society_id)
    end
  
end
