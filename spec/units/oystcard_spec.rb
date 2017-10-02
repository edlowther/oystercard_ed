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
      it 'increases the balance by the correct amount' do
        current_balance = subject.balance
        subject.top_up 20
        expect(subject.balance).to eq current_balance + 20
      end
    end
  end
end
