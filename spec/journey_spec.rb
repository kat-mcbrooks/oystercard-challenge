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

  context 'when given an entry station' do
  subject { described_class.new(entry_station: station) } #would described_class.new( station) work if we iniitalised with entry_station=nil rather than entry_station: nil?

    it 'charges penalty if no exit station given' do
      expect(subject.fare).to eq penalty_fare
    end

    it 'knows its entry station' do #tests that it starts a journey
      expect(subject.entry_station).to eq station
    end

    context 'and when given an exit station' do
      let(:exitstation) { double("exitstation") }
      before do
        subject.finish(exitstation)
      end

      it 'journey is complete' do # tests that it finishes a journey
        expect(subject).to be_complete
      end

      it 'charges min fare' do
        expect(subject.fare).to eq min_fare
      end
    end
  end
end