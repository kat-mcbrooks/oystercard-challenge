require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :journey_log # we use this instead of a getter method (def @balance end) so that we can run oystercard.balance or oystercard.journeys to see balance and journeys history
  MAX_BALANCE = 90
  MIN_FARE = 1
  def initialize(journeylog = JourneyLog.new) #use dependency injection here so that in the tests we can double it. By putting JourneyLog.new here instead of within the method, it means we can pass in a double
    @balance = 0
    @journey_log = journeylog
  end

  def top_up(value) 
    raise "Unable to top up - you have reached your maximum balance of £#{MAX_BALANCE}." if @balance + value > MAX_BALANCE
    @balance += value 
  end

  def touch_in(station=nil)
    raise "Insufficient funds" unless balance >= MIN_FARE
    @journey_log.start(station) #runs journeylog class method on an instance of journeylog. This method creates new instance of journey class and adds it to the @log, so touch_in will return @log, which will be one or many instances of journey
  end

  def touch_out(station=nil)
    j = @journey_log.finish(station) #running journeylog finish method on journeylog instance, returns an instance of journey, which we can then run fare on below
    deduct(j.fare)
  end
  
  private

  def deduct(value) #private means method can only be called within the Class
    @balance -= value
  end
end

p oc = Oystercard.new
p oc.balance
p oc.touch_out("Euston")
p oc.journey_log
