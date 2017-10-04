require 'oystercard'

feature 'Getting started' do
  let(:brixton) { double(:station, :name => "Brixton") }
  let(:pimlico) { double(:station, :name => "Pimlico") }
  let(:card) { Oystercard.new }
  before(:each) { card.top_up 10 }
  it 'shows journey history' do
    card.touch_in brixton
    card.touch_out pimlico
    p card.history
  end
  it 'registers an incomplete journey if customer fails to touch out' do
    card.touch_in brixton
    card.touch_in pimlico
    p card.history
  end
end
