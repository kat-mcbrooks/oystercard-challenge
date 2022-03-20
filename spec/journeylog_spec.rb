require 'journeylog'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:station) { double :station }  
  let(:journey_class) {double :journey_class, new: journey} #use the let method to set the double we have created to the variable :journey_class. Then used the double method to set new method to return journey
  subject {described_class.new(journey_class)} #because we've used dependency injection to inject JourneyLog class with Journey

  describe '#start journey' do
    it 'starts a journey' do #we are testing how journeylog class interacts with journey class without depending on journey class to work(using double)
      expect(journey_class).to receive(:new).with(entry_station: station) 
      subject.start(station)
    end

    it 'records a journey' do
      subject.start(station)
      expect(subject.log).to include(journey)
    end
  end

  it 'stops a current journey' do
    subject.start(station)
    expect(journey).to receive(:finish).with(station) #testing that journey will receive Journey class finish method when the journeylog finish method is called (on line below)
    subject.finish(station)
  end

  context 'with an open journey' do
    before do 
      subject.start(station)
    end

    it 'returns an open journey when stopping' do
      allow(journey).to receive(:finish).with(station).and_return(journey)
      expect(subject.finish(station)).to eq journey
    end
  end

   it 'creates/returns a new Journey when there is not a current journey when stopping' do
    allow(journey).to receive(:finish).with(station).and_return journey 
    expect(subject.finish(station)).to eq journey #this will run the current_journey method, which will return journey_class.new because there is no current_journey. We have instructed journey_class to respond to new in line 6 and return journey
    end

  it 'returns an array of previous journeys' do
    expect(subject.journeys).to be_kind_of Array
  end
end