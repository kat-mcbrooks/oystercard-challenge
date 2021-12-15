require 'station'

describe Station do
  #let(:name) { double 'name' }
  #let(:station_zone) { double 'zone' }
  subject {described_class.new("Euston", 1)} #sets the subject in all tests to be passed. Need to do this because the Class needs two arguments to be given when called. Walkthrough seems to pass a hash to the class here, but I'm not sure how or why you do this?!
  
  it 'knows its name' do
    expect(subject.name).to eq "Euston"
  end
  
  it 'knows its zone' do
    expect(subject.zone).to eq 1
  end
end