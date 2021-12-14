class Oystercard
  attr_reader :balance # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
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

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @tracker
  end

  def touch_in
    raise "Insufficient funds" unless balance >= MIN_FARE 
    @tracker = true
  end

  def touch_out
    @tracker = false
    deduct(1)
  end

end