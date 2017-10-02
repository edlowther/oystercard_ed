require 'oystercard'

describe Oystercard do
  context "when brand new" do
    describe "#balance" do
      it 'is zero' do
        expect(subject.balance).to eq 0
      end
    end
  end
  context "when active" do

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

    end
  end
end
