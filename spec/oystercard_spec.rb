require 'oystercard'

describe Oystercard do 
  min_fare = Oystercard::MIN_FARE #syntax for accessing constant outside a class?
  max_balance = Oystercard::MAX_BALANCE 
  let(:entry_station) {double 'Euston'}
  let(:exit_station) {double 'Greenwich'}
  let(:journey) {double 'journey', fare: min_fare } 
  let(:journeylog){double 'journeylog', start: [journey], finish: journey}
  subject { described_class.new(journeylog) }

  it 'has balance of 0 by default' do
    expect(subject.balance).to eq (0) 
  end

  describe '#top_up' do 
    it 'changes card balance with a value' do
      expect{ subject.top_up(max_balance) }.to change{ subject.balance }.by(max_balance)
    end

    it 'raises error if you try to top up above the maximum card balance' do
      subject.top_up(max_balance) # sets up for the expectation of the test below (Assert)
      expect { subject.top_up(1) }.to raise_error "Unable to top up - you have reached your maximum balance of £#{max_balance}."
    end
  end

  describe '#touch_out' do
    before do 
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
    end
    it 'charges card with journey fare' do
    expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-journey.fare)
    end

    it 'tells journey log which station was touched out' do
    expect(journeylog).to receive(:finish).with(exit_station)
    subject.touch_out(exit_station)
    end
  end

  describe '#touch_in' do
    it 'raises error when attempting to touch in with balance under minimum fare' do
      expect { subject.touch_in(entry_station) }.to raise_error("Insufficient funds")
    end

    context 'with sufficient funds' do 
      before do 
       subject.top_up(min_fare)
      end 

      it 'knows what station it has touched in at' do
        expect(journeylog).to receive(:start).with(entry_station)   
        subject.touch_in(entry_station)
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