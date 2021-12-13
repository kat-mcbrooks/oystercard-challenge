class Oystercard
  attr_reader :balance # we use this instead of a getter method (def @balance end) so that we can access/get the balance attribute outside the class e,g, in tests 
  
  def initialize
    @balance = 0
  end

  def top_up(value) 
    @balance += value 
  end
end