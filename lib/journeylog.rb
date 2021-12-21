require_relative 'journey'

class JourneyLog
  attr_reader :journey_class, :log
  def initialize(journey_class= Journey)
    @journey_class = journey_class
    @log = [] #if we were to make this an attr_reader, it would be exposed to external modification i.e. we could run methods like @journeys.delete on it. This array contains istances of Journey

  end

  def start(entry = nil) 
    journey = journey_class.new(entry_station: entry)
    @log << journey
  end

  def finish(final = nil)
    current_journey.finish(final)  #current_journey is an instance of journey, created via current_journey method below. Here, we are running the current_journey method and calling finish (the Journey class method) on it
    #@current_journey = nil 
  end

  def journeys # so that we can call journeys and get an array of journeys without affecting @log 
    @log.map(&:clone) # &: means 'run this for each element' so we are going to get another array which is exactly the same
  end

  private #means only this particular class in this file can call the method. 
  attr_reader :journey_class
  def current_journey
    @current_journey ||= journey_class.new # this means: if @current_journey is nill, undefined or falsey, assign Journey.new to @current_journey. 
    # @current_journey = Journey.new unless @current_journey (the above line is a shortcut for this)
  end

  #def current_journey #this method needs to return an instance of journey
   # if @log[-1].complete? #if the current journey at this moment is complete, we need to make a new journey. This will be the case when someone touches out, without touching in first. 
    #  @log << Journey.new #new instance of journey added to log, entry_station will be nil 
    #end
     # @log[-1] #returns an incomplete journey
  #end
end

p j = JourneyLog.new
p j.start("Euston")
p j.log