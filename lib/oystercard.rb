class Oystercard
  attr_reader :balance, :entry_station # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @tracker = false
  end

  def top_up(value) 
    raise "Unable to top up - you have reached your maximum balance of £#{MAX_BALANCE}." if @balance + value > MAX_BALANCE
    @balance += value 
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    raise "Insufficient funds" unless balance >= MIN_FARE 
    @tracker = true
    @entry_station = station  
  end

  def touch_out
    @tracker = false
    deduct(1)
    @entry_station = nil
  end

  #private
  def deduct(value) #not sure why we want deduct private but not others?
    @balance -= value
  end

end