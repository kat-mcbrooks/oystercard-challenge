require 'oystercard'

describe Oystercard do 
  it 'has balance of 0 by default' do
    expect(subject.balance).to eq (0) 
  end

  describe '#top_up' do # tests for the top_up method can go under this describe? 
    # it { is_expected.to respond_to(:top_up).with(1).argument } THIS TEST IS NOW REDUNDANT AS WE TEST THIS VIA THE BELOW
    it 'card balance can be topped up with a value' do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end

    it 'raises error if you try to top up above the maximum card balance' do
      max_balance = Oystercard::MAX_BALANCE # read up on this syntax
      subject.top_up(max_balance) # sets up for the expectation of the test below (Assert)
      expect { subject.top_up(1) }.to raise_error "Unable to top up - you have reached your maximum balance of £#{max_balance}."
    end
  end

  describe '#deduct' do 
    it 'deduct will reduce card balance by given value' do
      subject.top_up(20)
      expect{ subject.deduct(10) }.to change{ subject.balance }.by(-10)
    end
  end

  describe 'tracking if card is in journey or not' do
    it 'begins not in_journey' do
      expect(subject).not_to be_in_journey
    end

    it 'can touch in and will then be in journey' do
      min_fare = (Oystercard::MIN_FARE) #syntax for accessing constant outside a class?
      subject.top_up(min_fare)
      subject.touch_in
      expect(subject).to be_in_journey
    end 

    it 'can touch out and will then not be in journey' do
      subject.top_up(1)
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it 'raises error when attempting to touch in with balance under minimum fare' do
      expect { subject.touch_in }.to raise_error("Insufficient funds")
    end

  end
end
