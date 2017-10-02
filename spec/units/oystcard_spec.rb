require 'oystercard'

describe Oystercard do
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
        current_balance = subject.balance
        subject.top_up 20
        expect(subject.balance).to eq current_balance + 20
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

    describe "#deduct" do
      it "reduces the balance by the correct amount" do
        fare = 2.8
        subject.top_up 20
        subject.deduct fare
        expect(subject.balance).to eq 20 - fare
      end
    end

    describe "#in_journey?" do
      it { is_expected.to respond_to :in_journey? }
    end

    describe "#touch_in" do
      it "registers that the card is 'in_journey'" do
        subject.touch_in
        expect(subject.in_journey?).to eq true
      end
    end

    describe "#touch_out" do
      it "registers that the journey has ended" do
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end
    end

  end
end
