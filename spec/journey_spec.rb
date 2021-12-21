require 'journey'

describe Journey do
  min_fare = Journey::MIN_FARE
  penalty_fare = Journey::PENALTY_FARE
  let(:station) { double :station, zone: 1}

  it 'is incomplete if no entry station given' do
    expect(subject).not_to be_complete
  end

  it 'charges penalty fare if no entry station given' do
    expect(subject.fare).to eq penalty_fare
  end

  it "will return journey itself when finishing a journey so that this journey can be " do #walkthrough test has 
    subject.finish(station)
    expect(subject.exit_station).to eq(station)
  end

  context 'when given an entry station' do
  subject { described_class.new(entry_station: station) }

    it 'charges penalty if no exit station given' do
      expect(subject.fare).to eq penalty_fare
    end

    it 'knows its entry station' do #tests that it starts a journey
      expect(subject.entry_station).to eq station
    end

    it 'completes journey when journey is finished without an exit station' do
      subject.finish
      expect(subject).to be_complete
    end

    context 'and when given an exit station' do
      let(:exitstation) { double("exitstation") }
      before do
        subject.finish(exitstation)
      end

      it 'knows its exit station' do 
        expect(subject.exit_station).to eq exitstation
      end

      it 'journey is complete' do
        expect(subject).to be_complete
      end

      it 'charges min fare' do
        expect(subject.fare).to eq min_fare
      end
    end
  end
end

