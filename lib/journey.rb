

class Journey
  attr_reader :entry_station, :exit_station, :log
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station: nil) #could also do (entry_station=nil)
    @entry_station = entry_station
    @log = {entry_stat: entry_station, exit_stat: nil} #alternative to line below but couldn't make it work
    # @journey = {"Entry Station" => entry_station, "Exit Station" => nil}
    #@exit_station = nil
  end

  def finish(exit_station=nil)
    @exit_station = exit_station
    @log[:exit_stat] = exit_station #adding the exit station to the journey hash
  end

  def fare
    if @exit_station.nil? || @entry_station.nil? 
      6
    else
      MIN_FARE
    end
  end

  def complete? 
    !@entry_station.nil? && !@exit_station.nil?
  end
end

p journey1 = Journey.new(entry_station: "Euston")
p journey1.complete?
p journey1.finish("Greenwich")
p journey1.log
p journey1.fare
p journey1.complete?