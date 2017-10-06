require 'journey'

describe Journey do
  let(:brixton) { double(:station, :name => "Brixton") }
  let(:pimlico) { double(:station, :name => "Pimlico") }

  it 'is recorded as incomplete if customer fails to touch out' do
    journey = Journey.new
    journey.start brixton
    expect(journey.complete?).to eq false
  end
  it 'is recorded as incomplete if customer fails to touch in' do
    journey = Journey.new
    journey.finish pimlico
    expect(journey.complete?).to be false
  end
  it 'returns a fare of £1 if the journey is complete' do
    journey = Journey.new
    journey.start brixton
    journey.finish pimlico
    expect(journey.fare).to eq 1
  end
  it 'returns a fare of £6 if the journey is incomplete' do
    journey = Journey.new
    journey.start brixton
    expect(journey.fare).to eq 6
  end
  it 'has a start method that takes an entry station as an argument' do
    journey = Journey.new
    journey.start brixton
    expect(journey.entry_station).to eq brixton
  end
  it 'has a finish method that takes an exit station as an argument' do
    journey = Journey.new
    journey.finish pimlico
    expect(journey.exit_station).to eq pimlico
  end
end
