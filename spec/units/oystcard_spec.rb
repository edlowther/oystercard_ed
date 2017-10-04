require 'oystercard'

describe Oystercard do
  let(:seven_sisters) { double(:station, :name => "Seven Sisters") }
  max_value = Oystercard::MAX_VALUE
  min_fare = Oystercard::MIN_FARE
  context "when brand new" do
    describe "#balance" do
      it 'is zero' do
        expect(subject.balance).to eq 0
      end
    end
    describe '#touch_in' do
      it "refuses to touch in as balance too low" do
        expect { subject.touch_in seven_sisters }.to raise_error "Must have at least £#{min_fare} on card to travel"
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
        subject.touch_in seven_sisters
        expect(subject.in_journey?).to eq true
      end

      it "registers station at start of journey" do
        subject.touch_in seven_sisters
        expect(subject.entry_station).to eq seven_sisters
      end
    end

    describe "#touch_out" do
      it "registers that the journey has ended" do
        subject.touch_in seven_sisters
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end
      it "removes reference to entry_station on card" do
        subject.touch_in seven_sisters
        subject.touch_out
        expect(subject.entry_station.nil?).to eq true
      end
      it "reduces the balance by the minimum fare" do
        expect { subject.touch_out }.to change { subject.balance }.by -1
      end
    end

  end
end
