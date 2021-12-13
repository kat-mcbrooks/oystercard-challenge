require 'oystercard'

describe Oystercard do 
  it 'has balance of 0 by default' do
    expect(subject.balance).to eq (0) 
  end

  describe '#top_up' do # tests for the top_up method can go under this describe? 
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'card balance can be topped up with a value' do
      expect {subject.top_up(20) }.to change{ subject.balance }.by(20)
    end
  end
end
