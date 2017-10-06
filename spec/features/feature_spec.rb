require 'oystercard'
require 'station'

feature 'Card is usable' do
  let(:brixton) { Station.new "Brixton", 2 }
  let(:pimlico) { Station.new "Pimlico", 1 }
  let(:card) { Oystercard.new }
  before(:each) { card.top_up 10 }
  it 'shows journey history' do
    card.touch_in brixton
    card.touch_out pimlico
    card.touch_in pimlico
    card.touch_out brixton
    p card.journeylog.journeys
  end
  it 'deducts correct fare if touched in and out' do
    card.touch_in brixton
    card.touch_out pimlico
    p card.balance
  end
  it 'deducts a penalty fare if customer fails to touch out' do
    card.touch_in brixton
    card.touch_in pimlico
    p card.balance
  end
end
