require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journeys, :currentjourney, :entry_station, :exit_station # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
  MAX_BALANCE = 90
  MIN_FARE = 1
  def initialize
    @balance = 0
    @journeys = [] #array of hashes?
    @currentjourney = nil
  end

  def top_up(value) 
    raise "Unable to top up - you have reached your maximum balance of £#{MAX_BALANCE}." if @balance + value > MAX_BALANCE
    @balance += value 
  end

  def touch_in(entry_station=nil)
    raise "Insufficient funds" unless balance >= MIN_FARE
    @currentjourney = Journey.new(entry_station: entry_station) 
    #@journey.entry_station
  end

  def touch_out(exit_station=nil)
    @currentjourney.finish(exit_station)
    deduct(@currentjourney.fare)
    store_journey
    @currentjourney
    @currentjourney = nil
  end
  
  def in_journey? 
    !@currentjourney.nil?
  end
  private
    
  def store_journey
    @journeys << {entry_stat: @currentjourney.entry_station, exit_stat: @currentjourney.exit_station}
  end

  def deduct(value) #not sure why we want deduct private but not others?
    @balance -= value
  end
end

p card = Oystercard.new
p card.top_up(1)
p card.touch_in("Euston")
p card.in_journey?
p card.touch_out("Greenwich")
p card.journeys
p card.in_journey? 
p card.currentjourney
