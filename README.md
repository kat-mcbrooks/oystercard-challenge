Week 2 challenge of Makers | User requirements:

Oystercard class responsible for: 
Storing money on card (@balance instance variable)
Adding money to card (top_up)
does not allow user to top up above max balance (MAX_BALANCE constant and raise error)
deducts fare from card (this will call on Journey class' fare method)
touch in (creates new Journey instance)
touch out method (calls on Journey's finish method)
does not allow user to touch_in without MIN_FARE
charges card on touch_out (so customer pays for journey when its complete)
can access Journeylog

Journey class responsible for: 
holds information about one single journey
calculates fare and knows penalty fare should be charged if journey incomplete (i.e. if either entry or exit station isn't given)

Journeylog class responsible for: 
Adding individual Journeys to Journeylog which Oystercard should be able to access

Station class responsible for: 
holds information about a station (name and zone)

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated

----------------------------------------------------------------
Manually testing the code in irb

katbrooks@Kats-Air oystercard % irb -r './lib/oystercard'
3.0.2 :001 > my_oyster = Oystercard.new
 => #<Oystercard:0x000000012080f2e8 @balance=0> 
3.0.2 :002 > 
 => 5 
3.0.2 :003 > my_oyster.balance
 => 5 
3.0.2 :005 > my_oyster.top_up(10)
 => 15 
3.0.2 :006 > my_oyster.balance
 => 15 
 3.0.2 :006 > my_oyster.top_up(90)
 => 90 
3.0.2 :007 > my_oyster.top_up(1)
/Users/katbrooks/Projects/oystercard/lib/oystercard.rb:12:in `top_up': Unable to top up - you have reached your maximum balance of \xC2\xA390. (RuntimeError)
3.0.2 :010 > my_oyster.in_journey?
 => true 
3.0.2 :011 > my_oyster.touch_out
 => 89 
3.0.2 :012 > my_oyster.in_journey?
 => false 
3.0.2 :013 > my_oyster.balance
 => 89 
3.0.2 :014 > my_oyster.entry_station # testing that we know where we've travelled from
(irb):14:in `<main>': undefined method 'entry_station' for #<Oystercard:0x00000001583005d0 @balance=89, @tracker=false> (NoMethodError)

p card = Oystercard.new
p "here"
p card.top_up(1)
p card.touch_in("Euston")
#p card.currentjourney
p card.in_journey?
p card.touch_out("Greenwich")
#p card.currentjourney
p card.journeys
p card.in_journey? 
#p card.currentjourney


p journey1 = Journey.new(entry_station: "Euston")
p journey1.complete?
p journey1.finish("Greenwich")

p journey1.fare
p journey1.complete?