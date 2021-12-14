require 'oystercard'

describe Oystercard do 
  min_fare = (Oystercard::MIN_FARE) #syntax for accessing constant outside a class?
  max_balance = Oystercard::MAX_BALANCE # read up on this syntax
  # subject (:oystercard) { Oystercard.new} optional, but would mean all tests below could use oystercard rather than subject i.e. perhaps clearer
  let(:entry_station) {double 'entry station double'}
  
  it 'remembers the entry station after touch in' do
    subject.top_up(min_fare)
    expect(subject.touch_in("King's Cross")).to eq "King's Cross"
  end 

  it 'has balance of 0 by default' do
    expect(subject.balance).to eq (0) 
  end

  describe '#top_up' do # tests for the top_up method can go under this describe? 
    # it { is_expected.to respond_to(:top_up).with(1).argument } THIS TEST IS NOW REDUNDANT AS WE TEST THIS VIA THE BELOW
    it 'card balance can be topped up with a value' do
      expect{ subject.top_up(20) }.to change{ subject.balance }.by(20)
    end

    it 'raises error if you try to top up above the maximum card balance' do
      subject.top_up(max_balance) # sets up for the expectation of the test below (Assert)
      expect { subject.top_up(1) }.to raise_error "Unable to top up - you have reached your maximum balance of £#{max_balance}."
    end
  end

  it 'begins not #in_journey' do
  expect(subject).not_to be_in_journey
  end

  describe '#touch_out' do
    it 'charges card' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      expect{ subject.touch_out }.to change{ subject.balance }.by(-min_fare)
    end

    it 'after touch_out, card will not be in journey' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      subject.touch_out
      expect(subject).to_not be_in_journey
    end

    it 'sets entry_station to nil' do
    subject.touch_out
    expect(subject.entry_station).to eq nil
    end
  end

  describe '#touch_in' do
    it 'after touch_in, card will be in_journey' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end 

    it 'raises error when attempting to touch in with balance under minimum fare' do
      expect { subject.touch_in(entry_station) }.to raise_error("Insufficient funds")
    end
  end
end

#describe '#deduct' do #this test is now redundant because deduct method is tested within the touch_out test 
#it 'reduces card balance by given value' do
 # subject.top_up(20)
  # expect{ subject.deduct(10) }.to change{ subject.balance }.by(-10)
#end
#end