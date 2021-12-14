Week 2 challenge of Makers | User requirements:

In order to use public transport
As a customer
I want money on my card 

    - To satisfy this user story, I added a default balance variable via initialize method to every instance of Oystercard class.  

In order to keep using public transport
As a customer
I want to add money to my card

    - To satisfy this user story, I added a top_up method with a value argument, which increases the balance of the card.

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

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
 3.0.2 :014 > my_oyster.origin #testing that we know where we've travelled from
(irb):14:in `<main>': undefined method `origin' for #<Oystercard:0x00000001583005d0 @balance=89, @tracker=false> (NoMethodError)
