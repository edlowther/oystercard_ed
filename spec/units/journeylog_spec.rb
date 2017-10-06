require 'journeylog'

describe JourneyLog do
  let(:card) { double(:card, :deduct => true) }
  subject(:journeylog) {described_class.new }
  let(:brixton) { double(:station, :name => "Brixton", :zone => 2) }
  let(:pimlico) { double(:station, :name => "Pimlico", :zone => 1) }
  it 'is initialized with an empty array to store journeys in' do
    expect(journeylog.journeys).to eq []
  end
  describe '#start' do
    it 'initializes a Journey instance that is stored in current_journey' do
      journeylog.start brixton
      expect(journeylog.current_journey).to be_a Journey
    end
  end
  describe '#finish' do
    it 'adds an exit_station to the current_journey' do
      journeylog.start brixton
      journeylog.finish pimlico
      expect(journeylog.journeys[-1]).to be_complete
    end
  end
end
