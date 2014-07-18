class EventsController < ApplicationController

  def create
    puts "____________________#{event_params}________________"
    @event = Event.new(event_params)
    puts "ERROR" unless @event.save
    render json: { event: @event }
    puts "************************************#{@event}"
  end

  def index
    first = Date.parse("#{params[:currentMonth]}-01")
    last = first.end_of_month
    @events = Event.where('date >= ? AND date <= ?', first, last)
    render json: { events: @events }
  end

  # def show
  #   debugger
  #   puts 'dougs'  
  # end

  # def destroy
  #   debugger
  #   puts 'dougs'  
  # end

 private

    def event_params
      params.require(:event).permit(:id, :date, :begin_time, :end_time, :latitude, :longitude, :description, :current_month, :name)
    end

end
