class Oystercard
  attr_reader :balance, :journeys, :journey # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journeys = [] #array of hashes?
    @journey = {"Entry Station" => nil, "Exit Station" => nil}
  end

  def top_up(value) 
    raise "Unable to top up - you have reached your maximum balance of £#{MAX_BALANCE}." if @balance + value > MAX_BALANCE
    @balance += value 
  end

  def in_journey?
    !@journey["Entry Station"].nil? && @journey["Exit Station"].nil?
    #!@entry_station.nil?
  end

  def touch_in(station)
    raise "Insufficient funds" unless balance >= MIN_FARE
    @journey["Entry Station"] = station
  end

  def touch_out(station)
    deduct(1)
    @journey["Exit Station"] = station
    store_journey
  end

  #private
  
  def store_journey
    @journeys << @journey
  end
    
  def deduct(value) #not sure why we want deduct private but not others?
    @balance -= value
  end

end