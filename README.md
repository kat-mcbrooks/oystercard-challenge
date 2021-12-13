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
3.0.2 :002 > my_oyster.top_up(5)
 => 5 
3.0.2 :003 > my_oyster.balance
 => 5 
3.0.2 :005 > my_oyster.top_up(10)
 => 15 
3.0.2 :006 > my_oyster.balance
 => 15 