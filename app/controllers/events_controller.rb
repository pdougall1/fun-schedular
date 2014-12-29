class EventsController < ApplicationController

  def create
    @event = current_user.events.new(event_params)
    puts "ERROR" unless @event.save
    render json: { event: @event }
  end

  def index
    date = Date.parse(params[:currentMonth] + "-01")
    events = Event.all_for_ember(current_user, date)
    render json: events
  end

  def show
    event = Event.find(any_params[:id])
    render json: {event: event}
  end

  private

    def event_params
      params.require(:event).permit(:id, :date, :begin_time, :end_time, :latitude, :longitude, :description, :current_month, :name)
    end

    def any_params
      params.permit(:id)
    end

end
