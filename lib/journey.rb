class Journey
  attr_reader :entry_station, :exit_station, :complete
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station: nil) #could also do (entry_station=nil)
    @entry_station = entry_station
    @complete = false
    #@log = {entry_stat: entry_station, exit_stat: nil} #this stores a log of the entry, exit stations of one journey only.
    #could set complete to false here
  end

  def finish(station=nil)
    @exit_station = station
    @complete = true
    self # needs to return the instance of journey so that when we run journeylog's finish method, we will get back the instance of journey
    # @complete = true could use this instead and set @complete = false at  start? But i don't agree this is such a good way because what if someone didn't touch in but did touch out. it's incomplete?
    # self put this line if you want to print the journey instance (self prints )
    #@log[:exit_stat] = exit_station #(look at Alex's recording, but think this could happen within oystercard method?)
    #@log
    #adding the exit station to the journey hash
  end

  def fare 
    @exit_station.nil? || @entry_station.nil? ? PENALTY_FARE : MIN_FARE
    #if @exit_station.nil? || @entry_station.nil? 
     #   6
    #else
     # MIN_FARE
    #end
  end

  def complete? #this replaces this 'in_journey' method. It does not determine the fare, so should be complete whenever the card is not in_journey
    @complete
  end
end


