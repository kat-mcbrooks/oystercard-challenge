require 'oystercard'

describe Oystercard do 
  min_fare = Oystercard::MIN_FARE #syntax for accessing constant outside a class?
  max_balance = Oystercard::MAX_BALANCE # read up on this syntax
  # subject (:oystercard) { Oystercard.new} optional, but would mean all tests below could use oystercard rather than subject i.e. perhaps clearer
  let(:entry_station) {double 'Euston'}
  let(:exit_station) {double 'Greenwich'}
  #let(:journey) { {entry_stat: entry_station, exit_stat: exit_station} } #try to work this out. why we use it and why it helps below, why its valid to use it 
  #let(:journeynew) { Journey.new(entry_station: entry_station)}
  it 'has empty list of journeys as default' do
    expect(subject.journeys).to be_empty
  end

  it 'has balance of 0 by default' do
    expect(subject.balance).to eq (0) 
  end

  it 'is not #in_journey  by default' do
    expect(subject).not_to be_in_journey
  end

  describe '#top_up' do # tests for the top_up method can go under this describe? 
    # it { is_expected.to respond_to(:top_up).with(1).argument } THIS TEST IS NOW REDUNDANT AS WE TEST THIS VIA THE BELOW
    it 'changes card balance with a value' do
      expect{ subject.top_up(max_balance) }.to change{ subject.balance }.by(max_balance)
    end

    it 'raises error if you try to top up above the maximum card balance' do
      subject.top_up(max_balance) # sets up for the expectation of the test below (Assert)
      expect { subject.top_up(1) }.to raise_error "Unable to top up - you have reached your maximum balance of £#{max_balance}."
    end
  end

  it 'touch in and touch out creates one journey' do
    subject.top_up(min_fare)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys.count).to eq 1
  end

  describe '#touch_out' do
      before do 
        subject.top_up(min_fare)
        subject.touch_in(entry_station)
      end
      it 'charges card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_fare)
      end

      it 'after touch_out, card will not be in journey' do
        subject.touch_out(exit_station)
        expect(subject).to_not be_in_journey
      end

      it 'stores journey' do
      subject.touch_out(exit_station)
      expect(subject.journeys).to include {entry stat: entry_station, exit_stat: exit_station} #or include subject.journy? not sure about this test
      end
  end

  describe '#touch_in' do
    it 'raises error when attempting to touch in with balance under minimum fare' do
      expect { subject.touch_in(entry_station) }.to raise_error("Insufficient funds")
    end

    context 'with sufficient funds' do 
      #let(:journey) { double('journey double') } #not sure about this double, not sure if it even a viable use of a double. Does it make the tests pointless. Got a bit lost
      before do 
       subject.top_up(min_fare)
       subject.touch_in(entry_station)
      end 
      it 'will be in_journey' do #is this sufficient test coverage? Do I need to test anything else to test touching in with sufficient funds?
       # subject.top_up(min_fare)
       # subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
    end
  end
end

#describe '#deduct' do #this test is now redundant because deduct method is tested within the touch_out test 
#it 'reduces card balance by given value' do
 # subject.top_up(20)
  # expect{ subject.deduct(10) }.to change{ subject.balance }.by(-10)
#end
#end