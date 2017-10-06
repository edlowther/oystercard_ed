require 'journey'

describe Journey do
  let(:brixton) { double(:station, :name => "Brixton", :zone => 2) }
  let(:pimlico) { double(:station, :name => "Pimlico", :zone => 1) }
  let(:oxford_circus) { double(:station, :name => "Oxford Circus", :zone => 1) }
  let(:bond_street) { double(:station, :name => "Bond Street", :zone => 1) }
  let(:seven_sisters) { double(:station, :name => "Seven Sisters", :zone => 3) }
  let(:stockwell) { double(:station, :name => "Stockwell", :zone => 2) }
  let(:cockfosters) { double(:station, :name => "Cockfosters", :zone => 4) }

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
  it 'returns a fare of £6 if the journey is incomplete' do
    journey = Journey.new
    journey.start brixton
    expect(journey.fare).to eq 6
  end
  describe 'when journey is complete' do
    it 'returns a fare of £1 if the journey is complete and started and ended in the same zone' do
      journey = Journey.new
      journey.start brixton
      journey.finish stockwell
      expect(journey.fare).to eq 1
    end
    it 'returns a fare of £2 if the journey is complete and went from one zone to another' do
      journey = Journey.new
      journey.start brixton
      journey.finish pimlico
      expect(journey.fare).to eq 2
    end
    it 'returns a fare of £3 if the journey is complete and went across two zones' do
      journey = Journey.new
      journey.start seven_sisters
      journey.finish pimlico
      expect(journey.fare).to eq 3
    end
    it 'returns a fare of £4 if the journey is complete and went across three zones' do
      journey = Journey.new
      journey.start cockfosters
      journey.finish oxford_circus
      expect(journey.fare).to eq 4
    end
  end
end
