class Oystercard
  attr_reader :balance # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(value) 
    raise "Unable to top up - you have reached your maximum balance of £#{MAX_BALANCE}." if @balance + value > MAX_BALANCE
    @balance += value 
  end

  def deduct(value)
    @balance -= value
  end
end