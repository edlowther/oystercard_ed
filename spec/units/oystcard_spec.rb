require 'oystercard'

describe Oystercard do
  let(:seven_sisters) { double(:station, :name => "Seven Sisters") }
  context "when brand new" do
    describe "#balance" do
      it 'is zero' do
        expect(subject.balance).to eq 0
      end
    end
  end
  context "when adding money" do
    describe "#top_up" do
      max_value = Oystercard::MAX_VALUE

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

  context "when travelling" do
    min_fare = Oystercard::MIN_FARE

    describe "#in_journey?" do
      it { is_expected.to respond_to :in_journey? }
    end

    describe "#touch_in" do
      context "when balance too low" do
        it "refuses to touch in" do
          expect { subject.touch_in seven_sisters }.to raise_error "Must have at least £#{min_fare} on card to travel"
        end
      end
      context "when enough money on card" do
        it "registers that the card is 'in_journey'" do
          subject.top_up 30
          subject.touch_in seven_sisters
          expect(subject.in_journey?).to eq true
        end

        it "registers station at start of journey" do
          subject.top_up 30
          subject.touch_in seven_sisters
          expect(subject.entry_station).to eq seven_sisters
        end
      end
    end

    describe "#touch_out" do
      it "registers that the journey has ended" do
        subject.top_up 30
        subject.touch_in seven_sisters
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end

      it "removes reference to entry_station on card" do
        subject.top_up 30
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
