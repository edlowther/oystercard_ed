require 'oystercard'

describe Oystercard do
  let(:brixton) { double(:station, :name => "Brixton", :zone => 2) }
  let(:stockwell) { double(:station, :name => "Stockwell", :zone => 2) }
  let(:pimlico) { double(:station, :name => "Pimlico", :zone => 1) }
  max_value = Oystercard::MAX_VALUE
  min_fare = Oystercard::MIN_FARE
  context "when brand new" do
    it 'has no journey history' do
      expect(subject.journeylog.journeys).to eq []
    end
    describe "#balance" do
      it 'is zero' do
        expect(subject.balance).to eq 0
      end
    end
    describe '#touch_in' do
      it "refuses to touch in as balance too low" do
        expect { subject.touch_in pimlico }.to raise_error "Must have at least £#{min_fare} on card to travel"
      end
    end
    describe '#top_up' do
      it 'increases the balance by the correct amount' do
        expect { subject.top_up 20 }.to change { subject.balance }.by 20
      end
      it "works for balances up to £#{max_value}" do
        subject.top_up max_value
        expect(subject.balance).to eq max_value
      end

      it "fails if balance exceeds £#{max_value}" do
        expected_error_msg = "Max balance of £#{max_value} exceeded"
        expect { subject.top_up( max_value + 0.01) }.to raise_error expected_error_msg
      end

      it "does not work with negative amounts" do
        expected_error_msg = 'Cannot top-up with negative amount'
        expect { subject.top_up -1 }.to raise_error expected_error_msg
      end
    end
  end
  context "when topped up with initial balance" do
    before(:each) { subject.top_up(10) }
    describe "#touch_in" do
      it "initializes a journey and stores in journey log's current_journey instance variable" do
        subject.touch_in pimlico
        expect(subject.journeylog.current_journey).to be_a Journey
      end
      it "the current_journey is marked as incomplete" do
        subject.touch_in pimlico
        expect(subject.journeylog.current_journey).to_not be_complete
      end
      it "saves a journey to the journey log's journeys array" do
        subject.touch_in pimlico
        expect(subject.journeylog.journeys[0]).to be_a Journey
      end
      it 'reduces the balance by £6 if the previous journey was incomplete' do
        subject.touch_in pimlico
        expect { subject.touch_in pimlico }.to change { subject.balance }.by -6
      end

    end

    describe "#touch_out" do
      context 'when user had touched in' do
        before(:each) { subject.touch_in brixton }
        it "registers that the journey is complete if had touched in" do
          subject.touch_out pimlico
          expect(subject.journeylog.journeys[-1]).to be_complete
        end
        it "empties journey log's current_journey variable if journey is complete" do
          subject.touch_out pimlico
          expect(subject.journeylog.current_journey).to be_nil
        end
        it "reduces the balance by the correct fare" do
          expect { subject.touch_out stockwell }.to change { subject.balance }.by -1
        end
      end
      context 'when user had not touched in' do
        it 'reduces the balance by £6' do
          expect { subject.touch_out brixton }.to change { subject.balance }.by -6
        end
      end
    end

  end
end
