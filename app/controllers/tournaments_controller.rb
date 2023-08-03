class TournamentsController < ApplicationController
  before_action :select_tournament, only: [:show, :edit, :update, :destroy]
  
  def index
    @tournaments = Tournament.all.includes(:tournament_level).order(:name)
  end
  
  def show; end
    
  def new
    @tournament = Tournament.new
  end
  
  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      flash[:success] = "Tournament added!"
      redirect_to tournaments_path
    else
      render 'new'
    end
  end
  
  def edit; end
    
  def update
    if @tournament.update(tournament_params)
      flash['success'] = "Tournament updated!"
      redirect_to tournaments_path
    else
      render 'edit'
    end
  end

  def destroy
    @tournament.destroy ? flash[:success] = "Tournament deleted!" : flash[:danger] = "There was a problem deleting the tournament."
    redirect_to tournaments_path
  end
  
  private
    def select_tournament
      begin
        @tournament = Tournament.find(params[:id])
        # @tournament = Tournament.includes(:golfer_rounds, :golfer_events).find(params[:id])
      rescue StandardError => e
        redirect_to tournaments_path
        flash[:danger] = e.message
      end
    end
    
    def tournament_params
      params.require(:tournament).permit(:name, :course_id, :tournament_level_id)
    end
    
end
