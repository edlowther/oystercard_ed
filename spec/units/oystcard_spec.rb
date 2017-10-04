require 'oystercard'

describe Oystercard do
  let(:vauxhall) { double(:station, :name => "Vauxhall") }
  let(:pimlico) { double(:station, :name => "Pimlico") }
  max_value = Oystercard::MAX_VALUE
  min_fare = Oystercard::MIN_FARE
  context "when brand new" do
    it 'has no journey history' do
      expect(subject.history).to eq []
    end
    describe "#balance" do
      it 'is zero' do
        expect(subject.balance).to eq 0
      end
    end
    describe '#touch_in' do
      it "refuses to touch in as balance too low" do
        expect { subject.touch_in vauxhall }.to raise_error "Must have at least £#{min_fare} on card to travel"
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
      it "registers that the card is 'in_journey'" do
        subject.touch_in vauxhall
        expect(subject.in_journey?).to eq true
      end

      it "registers station at start of journey" do
        subject.touch_in vauxhall
        expect(subject.entry_station).to eq vauxhall
      end
    end

    describe "#touch_out" do
      before(:each) { subject.touch_in vauxhall }
      it "registers that the journey has ended" do
        subject.touch_out pimlico
        expect(subject.in_journey?).to eq false
      end
      it "removes reference to entry_station on card" do
        subject.touch_out pimlico
        expect(subject.entry_station.nil?).to eq true
      end
      it "reduces the balance by the minimum fare" do
        expect { subject.touch_out pimlico }.to change { subject.balance }.by -1
      end
      it 'adds a journey to the card history' do
        expect { subject.touch_out pimlico }.to change { subject.history.length }.by 1
      end
      it 'adds the correct entry station to the card history' do
        subject.touch_out pimlico
        expect(subject.history[0][:entry_station]).to eq vauxhall
      end
      it 'adds the correct exit station to the card history' do
        subject.touch_out pimlico
        expect(subject.history[0][:exit_station]).to eq pimlico
      end
    end

  end
end
