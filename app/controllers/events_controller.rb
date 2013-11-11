class EventsController < ApplicationController
  before_action :signed_in_user
  def show
   @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to event_path(@event)
    else
      @feed_items = []
      flash[:error] = "Event not valid. Please try again."
      redirect_to root_path
    end
  end

  def destroy
  end

  private

    def event_params
      params.require(:event).permit(:details, :start, :finish, :where)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end