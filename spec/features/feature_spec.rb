require 'oystercard'

feature 'Getting started' do
  card = Oystercard.new
  card.top_up 20
  fare = 1
  card.deduct fare
end
