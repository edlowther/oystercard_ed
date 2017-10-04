require 'oystercard'

feature 'Getting started' do
  let(:brixton) { double(:station, :name => "Brixton") }
  let(:pimlico) { double(:station, :name => "Pimlico") }
  it 'shows journey history' do
    card = Oystercard.new
    # card.top_up 20
    # card.touch_in brixton
    # card.touch_out pimlico
    # p card.history
  end
end
